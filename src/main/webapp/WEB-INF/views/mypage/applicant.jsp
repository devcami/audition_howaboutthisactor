<%@page import="java.sql.Date"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/applicant.css" />
<%
	List<Ann> list = (List<Ann>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	
%>
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
     <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>&memberRole=<%= loginMember.getMemberRole() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/companyInfo?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">담당자 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
    <div id="mywish">
    <div>
      <div id="wishlist-head">
        <h2>지원자 조회</h2>

      </div>
      <div id="updown-container">
      <% if(list != null && !list.isEmpty()){
			long miliseconds = System.currentTimeMillis();
			Date today = new Date(miliseconds); 
			for(int i = 0; i < list.size(); i++){ 
		%>
        <div 
        	class="card" data-bs-toggle="offcanvas" 
        	data-bs-target="#offcanvasTop" 
        	aria-controls="offcanvasTop"
        	onclick="applicantView(this);">
          <input type="hidden" value="<%= list.get(i).getAnnNo() %>">
          <div class="card-header">
            모집중
          </div>
          <div class="card-body">
            <div id="card-body-top">
              <h5 class="card-title"><%= list.get(i).getAnnTitle() %></h5>
              <p class="card-text"><%= list.get(i).getAnnRegDate() %> ~ <%= list.get(i).getAnnEndDate() %></p>
            </div>
            <div id="btn-div">
              <a 
              	href="<%= request.getContextPath() %>/ann/annView?annNo=<%= list.get(i).getAnnNo() %>" 
              	id="btnbtn" class="btn btn-primary">공고보러가기</a>
            </div>
          </div>
        </div>
              <% } %>
		<% } else { %>
			<div><p>조회된 공고가 없습니다.</p></div>
		<% } %> 

    </div>
	<div id="pagebar">
		<%= pagebar %>
	</div>
	
    </div>
        <div class="offcanvas offcanvas-top" tabindex="-1" id="offcanvasTop" aria-labelledby="offcanvasTopLabel">
           <div class="offcanvas-header">
          
            <div id="text-div">
              <h3 id="offcanvasTopLabel">공고명: 함께할 조연배우 모집합니다.</h3>
            </div>
            <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>

          </div>
          <div class="offcanvas-body" id="applicant-div">
         </div>
        </div>
    </div>
           
  <script>

  	const applicantView = (ann) => {
  		const annNo = ann.firstElementChild.value;
  		const div = document.getElementById("applicant-div");
  		$('#applicant-div').empty();
  		$('#smallLabel').remove();
  		$.ajax({
  			url: "<%= request.getContextPath() %>/mypage/getApplicant",
  			method: "POST",
  			dataType: "json",
  			data: {
  				"annNo" : annNo
  			},
  			success(applicants){
  				console.log("성공");
				const span  = `<span id="smallLabel">지원자가 없습니다.</span>`;
				
				if(applicants.length == 0) {
					console.log("시발");
					const textDiv = document.getElementById("text-div");
					textDiv.insertAdjacentHTML('beforeend', span);
					
				} else {
	  				applicants.forEach((actor, i) => {
	
	  				
	  					const actorLink = `<%= request.getContextPath() %>/actor/actorView?actorNo=\${actor.actorNo}`;
	  					console.log(actorLink);
	  				
	  					img_src = imgSrc(actor.attachment.renamedFilename);
	  					// const actorName = nvl(actor.actorName);
	  					// const company = nvl(actor.company);
	  					//const birth = nvl(actor.birth);
	  					//const phone = nvl(actor.phone);
	  					//email = nvl(actor.email);
	  	
	  					const wrap = `
	  			            <div class="wrapper">
	 		              		<img src="\${img_src}">
	 		              		<div class="bg"></div>
	  		              		<div class="view">
	  		                		<h3><span>\${nvl(actor.actorName)}</span></h3>
	  		                		<p>\${nvl(actor.company)}</p>
	  		                		<p>\${nvl(actor.birth)}</p>
	  		                		<p id="p-phone">\${nvl(actor.phone)}</p>
	  		                		<p>\${nvl(actor.email)}</p>
	  		                		<a href="#">상세보기</a>
	  		              		</div>
	  		            	</div>`;			
	  					div.insertAdjacentHTML('beforeend', wrap);			
	  				});	
				}
  			}, 
  			error: console.log
  			
  		});
  		
  	}
  
	function nvl(str){
		
		if(typeof str == "undefined" || str == null || str == "")
			str = `&nbsp;`
		
		return str;
	}
	
	function imgSrc(fileName) {
		
		if(fileName == "undefined" || fileName == null || fileName == "")
			return `<%= request.getContextPath() %>/images/default.png`;		
		
		return `<%= request.getContextPath() %>/upload/portfolio/\${fileName}`;
	}
  
  
	const annView = (ann) => {
		const annNo = ann.firstElementChild.lastElementChild.value;
		location.href=`<%= request.getContextPath() %>/ann/annView?annNo=\${annNo}`;
	};
 
    const mousein = (menu) => {
      now_menu.classList.remove('current');
      menu.classList.add('current');
    };

    const mouseout = (menu) => {
      now_menu.classList.add('current');
      menu.classList.remove('current');
    }
  </script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>