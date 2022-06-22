<%@page import="mypage.model.dto.PortAttachment"%>
<%@page import="mypage.model.dto.ActorInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String portType = (String) request.getAttribute("portType");
	ActorInfo actorInfo = (ActorInfo) request.getAttribute("actorInfo");
	String img_src = (String) request.getAttribute("img_src");
	
	
	String actorName = actorInfo.getActorName() != null ? actorInfo.getActorName() : "";
	int actorNo = actorInfo.getActorNo();
	String birth = actorInfo.getBirth() != null ? actorInfo.getBirth() : "";
	String education = actorInfo.getEducation() != null ? actorInfo.getEducation() : "";
	String company = actorInfo.getCompany() != null ? actorInfo.getCompany() : "";
	String phone = actorInfo.getPhone() != null ? actorInfo.getPhone() : "";
	String email = actorInfo.getEmail() != null ? actorInfo.getEmail() : "";
	String speciality = actorInfo.getSpeciality() != null ? actorInfo.getSpeciality() : ""; 
	String sns = actorInfo.getSns() != null ? actorInfo.getSns() : "";
	int attachNo = actorInfo.getAttachNo();
	
	int _age = actorInfo.getAge();
	String age = _age != 0 ? Integer.toString(_age) : "";	
	
	double _height = actorInfo.getHeight();
	String height = _height != 0 ? Double.toString(_height) : "";
	
	double _weight = actorInfo.getWeight();
	String weight = _weight != 0 ? Double.toString(_weight) : "";
	
	System.out.println("viewPortfolio.jsp@memberId = " + loginMember.getMemberId() + " 회원 포폴 조회(기존회원)");
	System.out.println("viewPortfolio.jsp@actorInfo = " + actorInfo.toString());
	System.out.println("viewPortfolio.jsp@img_src = " + img_src);
	System.out.println("viewPortfolio.jsp@attachNo = " + attachNo);
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/viewPortfolio.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="portfolio-container">
    <div id="portfolio_head">
      <h2>포트폴리오</h2>
      <form action="<%= request.getContextPath() %>/mypage/gotoEditPortfolio" style="margin: 0;">
      	  <input type="submit" id="update-btn" value="수정" class="btn" >
          <input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
          <input type="hidden" name="portType" value = "<%= portType %>" />        
          <input type="hidden" name="attachNo" value = "<%=  attachNo %>" />        
      </form>

    </div>
    <form name="portfolioFrm" method="post">
      <table id="portTable">
        <tbody>
          <tr>
            <th rowspan="9" id="img-th">대표사진</th>
            <td rowspan="9">
              <div id="profile-img-container">
                <img src="<%= img_src %>" id="profile-img">
              </div>
            </td>
            <th>이름</th>
            <td colspan="3">
              <span><%= actorName %></span>
              <!-- <input type="text" name="Pname" id="Pname" value="호시"> -->
            </td>
          </tr>
          <tr>
            <th>생년</th>
            <td style="width: 150px;">
            	<span><%= birth %></span>
              <!-- <input type="text" name="Pbirth" id="Pbirth" value="1996-06-15"> -->
            </td>
            <th style="text-align: right;">나이</th>
            <td>
            	<span><%= age %></span><% if(!age.isEmpty()) { %>세<% } %>
              <!-- <input type="text" name="Page" id="Page" value="27" style="text-align:right;">세 -->
            </td>
          </tr>
          <tr>
            <th>소속사</th>
            <td colspan="3">
            	<span><%= company %></span>
              <!-- <input type="text" name="company" id="company" value="플레디스"> -->
            </td>
          </tr>
          <tr>
            <th>학력</th>
            <td colspan="3">
            	<span><%= education %></span>
              <!-- <input type="text" name="school" id="school" value="한양대학교 미래인재교육원"> -->
            </td>
          </tr>
          <tr>
            <th>키</th>
            <td style="width: 150px;">
              <span><%= height %></span><% if(!height.isEmpty()) { %>cm<% } %>
              <!-- <input type="text" name="height" id="height" value="177" style="text-align:right;">
              <span>cm</span> -->
            </td>
            <th style="text-align: right;">체중</th>
            <td>
            	<span><%= weight %></span><% if(!weight.isEmpty()) { %>kg<% } %>
              <!-- <input type="text" name="weight" id="weight" value="60.9" style="text-align:right;">
              <span>kg</span> -->
            </td>
          </tr>
          <tr>
            <th>휴대폰</th>
            <td colspan="3">
            	<span><%= phone %></span>
              <!-- <input type="tel" name="Pphone" id="Pphone" value="010-1234-124"> -->
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td colspan="3">
              <span><%= email %></span>
              <!-- <input type="email" name="Pemail" id="Pemail" value="hosi@naver.com"> -->
            </td>
          </tr>
          <tr>
            <th>sns</th>
            <td colspan="3">
            	<span><%= sns %></span>
              <!-- <input type="text" name="Psns" id="Psns" value="instagram - @ho5hi_kwon"> -->
            </td>
          </tr>
          <tr>
            <th>특기</th>
            <td colspan="3">
            	<span><%= speciality %></span>
              	<!-- <input type="text" name="Pspeciality" id="Pspeciality" value="춤"> -->
            </td>
          </tr>
          
          
          <tr>
            <td><br></td>
          </tr>
        </tbody>
        
        <tbody id="addWork-tbody">
    	  <tr>
              <th colspan="2" id="work-wrap-th">경력</th>
              <td colspan="4" style="text-align:right;">
              	
              </td>
          </tr>
          <tr>
            <td colspan="6" style="border-top: 1px solid grey;"></td>
          </tr>
		</tbody>
		<!-- 여기에 경력이 하나씩 추가되는 것. --> 
      </table>
    </form>
  </div>
  <form name="viewWorkFrm" action="<%= request.getContextPath() %>/mypage/workView">
  	<input type="hidden" name="selectedWorkNo" id="selectedWorkNo"/>
  	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
  </form>
  
  <script>
  	window.onload = () => {
  		const ptable = document.getElementById("portTable"); 
  		console.log("ptable", ptable);
  		$.ajax({
  			url: "<%= request.getContextPath() %>/mypage/viewWork",
  			dataType: "json",
  			data : {
  				"memberId": "<%= loginMember.getMemberId() %>"
  			},
  			success(works){
  				
  				works.forEach((work, i) => {
  					console.log(work)
  					//console.log(work.attachment.renamedFilename);
  					//console.log(work.title);
  					//console.log(work.myrole);
  					//console.log(work.period);
  					console.log(work.no);
  					
  					
  					const img_src = `<%= request.getContextPath() %>/upload/portfolio/\${work.attachment.renamedFilename}`;
  					const tbodyId = "work" + work.no;
  					const index = i + 1;
  					
  	  				const trs = `
  	  				<tbody id="\${tbodyId}">
  	  		          <tr>
  	  		            <th rowspan="5" class="work-no">
  	  		            	<span>\${index}</span>
  	  		            </th>
  	  		            <td rowspan="5">
  	  		              <div id="work-img-container">
  	  		                <img src="\${img_src}" class="work-img" value="\${work.no}" onclick="viewWork(this);">
  	  		              </div>
  	  		            </td>
  	  		            <td><br><br></td>
  	  		          </tr>
  	  		          <tr class="work-tr">
  	  		            <th>작품명</th>
  	  		            <td colspan="3">\${work.title}</td>
  	  		          </tr>
  	  		          <tr class="work-tr">
  	  		            <th>배역</th>
  	  		            <td colspan="3">\${work.myrole}</td>
  	  		          </tr>
  	  		          <tr class="work-tr">
  	  		            <th>기간</th>
  	  		            <td colspan="3">\${work.period}</td>
  	  		          </tr>
  	  		          <tr>
  	  		            <td><br><br></td>
  	  		          </tr>
  	  		         <tbody>
  	  				`;
  	  				
  	  				ptable.insertAdjacentHTML('beforeend', trs);
  					
  				});
  				
  			},
  			error : console.log
  			
  		});  		
  		
  	}
  	
  	
	const viewWork = (e) => {		
		
		const workNo = e.getAttribute('value');
		document.getElementById("selectedWorkNo").value = workNo;
		console.log($('#selectedWorkNo').val())

		
  		const title = "viewWorkPopup";
  		const spec = "width=1000px, height=700px";
  		const popup = open("", title, spec);
 	
  		const frm = document.viewWorkFrm;
  		frm.target = title; // 해당 팝업에서 폼을 제출 
  		frm.submit();
		
	}
  
    const mousein = (menu) => {
      now_menu.classList.remove('current');
      menu.classList.add('current');
    };
  
    const mouseout = (menu) => {
      now_menu.classList.add('current');
      menu.classList.remove('current');
    }
    
    /**
     * 스크롤기능 안쳐먹음ㅠㅠ 
     * let currentPosition = $("#Pmypage-submenu").css("top"); 
     * 이새끼가 auto나옴 시부럴
     */
     let currentPosition = $("#Pmypage-submenu").css("top");
     console.log(currentPosition); 
     $(window).scroll(function(){   
        let position = $(window).scrollTop();
        $("#Pmypage-submenu").stop().animate({"top":position+currentPosition+"px"},1000);
      });
  </script>
  
  
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>