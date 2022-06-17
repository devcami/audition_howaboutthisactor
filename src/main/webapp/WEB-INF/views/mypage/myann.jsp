<%@page import="java.sql.Date"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
   
	List<Ann> list = (List<Ann>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
	long miliseconds = System.currentTimeMillis();
    Date today = new Date(miliseconds);
    

	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/myann.css" />

<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>&memberRole=<%= loginMember.getMemberRole() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applicantList" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/companyInfo?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">담당자 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
    <div id="mywish">
    <div>
      <div id="wishlist-head">
        <div id="left-head">
        	<h2>내 공고 조회</h2>
        </div>
        <div id="right-head">
        	<button type="button" class="btn" id="enroll-btn" onclick="location.href='<%= request.getContextPath() %>/ann/annEnroll';">공고등록</button>
   			<% if(list != null && !list.isEmpty()){ %>
            	<button type="button" class="btn" id="choice-btn" onclick="selectMode();">선택</button>
            	<button type="button" class="btn" id="cancel-btn" style="display:none;" onclick="viewMode();">취소</button>
            <% } %>
            <div id="sortType-wrap">
          		<select id="sortType" onchange="sortTypeChange(this);">
            		<option value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : ""%>>최신순</option>
            		<option value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : ""%>>마감순</option>
          		</select>
        	</div>
        </div>
      </div>
      <span id="selectMsg" style="display: none;">공고를 선택해주세요.</span>
      <div id="updown-container">
      <% if(list != null && !list.isEmpty()){
    	  
		for(int i = 0; i < list.size(); i++){ 
			
			if(list.get(i).getAnnEndDate().before(today)){ 
		%> 
					<div class="col" id="col<%= list.get(i).getAnnNo() %>">
			          <div class="card expirated"> <!--  onclick="annView(this);" -->
			            <div class="card-body">
			              <h5 class="card-title"><%= list.get(i).getAnnTitle() %></h5>
			              <p class="card-text"><%= list.get(i).getMemberId() %></p>
			              <input type="hidden" name="annNo" id="annNo" value="<%= list.get(i).getAnnNo() %>">
			            </div>
			            <div class="card-footer expFoot">
			              <small class="text-muted"><%= list.get(i).getAnnRegDate() %></small> ~ 
			              <small class="text-muted"><%= list.get(i).getAnnEndDate() %></small>
			            </div>
			          </div>
			        </div>	
		<%	} else { %>
				<div class="col" id="col<%= list.get(i).getAnnNo() %>">
		          <div class="card" onclick="annView(this)">
		            <div class="card-body">
		              <h5 class="card-title"><%= list.get(i).getAnnTitle() %></h5>
		              <p class="card-text"><%= list.get(i).getMemberId() %></p>
		              <input type="hidden" name="annNo" id="annNo" value="<%= list.get(i).getAnnNo() %>">
		            </div>
		            <div class="card-footer">
		              <small class="text-muted"><%= list.get(i).getAnnRegDate() %></small> ~ 
		              <small class="text-muted"><%= list.get(i).getAnnEndDate() %></small>	            
		            </div>
		          </div>
		        </div>				
<%  		}
		}		
    } else {
%>
	<p>등록된 공고가 없습니다.</p>
		
<% } %>
      </div>
      <div id="options" style="display: none;">
        <button type="button" class="btn small-btn" onclick="delAnn();">삭제</button>
       	<button type="button" class="btn small-btn" onclick="editAnn();">수정</button>
       	<button type="button" class="btn small-btn">마감처리</button>
      </div>
    </div>
	<div id="pagebar">
		<%= pagebar %>
	</div>

  </div>

  <script>
  
  sortType.addEventListener('change', (e) => {
      document.querySelector("#updown-container").innerHTML = "";
      const {value} = e.target;
      // 공고 마감순 선택 시 페이지 요청
      location.href=`/app/mypage/myAnnEndDate?sortType=\${value}`;
   });

   const annView = (ann) => {
      //const annNo = ann.firstElementChild.lastElementChild.value;
      const annNo = ann.currentTarget.firstElementChild.children.annNo.value;
      console.log(annNo);
   	  location.href=`/app/ann/annView?annNo=\${annNo}`;
   };
   
   $(".card").click(annView);
   
   let selectedAnn = [];
   const annSelect = (ann) => {
	   
	   if($(ann.currentTarget).hasClass("selected")){
		   $(ann.currentTarget).removeClass("selected");
	   } else {
		   $(ann.currentTarget).addClass("selected");
	   }
   } 
   
   const selectMode = () => {
	   // console.log("selectMode 실행");
	   //$(".card").removeEventListener('click', annView);
	   //sortType.removeEventListener('change', sortTypeChange);
	   $(".card").off("click");
	   $('#choice-btn').css('display', 'none');
	   $('#cancel-btn').css('display', '');
	   $('#options').css('display', '');
	   $('#selectMsg').css('display', '');
	   $(".card").click(annSelect);
	   
	   
   };
   
   const viewMode = () => {
	   $(".card").off("click");
	   $(".card").click(annView);
	   $('#choice-btn').css('display', '');
	   $('#cancel-btn').css('display', 'none');
	   $('#options').css('display', 'none');
	   $('#selectMsg').css('display', 'none');
	   
	   const annArr = Array.from(document.querySelectorAll('.card'));
	   ckremove(annArr);
	   
   }
   
   // ann 삭제하기
   const delAnn = () => {
	   const annArr = Array.from(document.querySelectorAll('.card'));
	   
	   const selectedArr = ckselected(annArr);
	   
	   console.log(selectedArr);
	   const msg = "총 " + selectedArr.length + "개의 파일이 선택되었습니다. 삭제하시겠습니까?"
	   const check = confirm(msg);
	   
	   if(check){
		   $.ajax({
			   url : "<%= request.getContextPath() %>/mypage/deleteAnn",
			   method : "POST",
			   dataType : "json",
			   data : {
				   "memberId" : "<%= loginMember.getMemberId() %>",
				   "deleteAnn" : selectedArr
			   },
			   success(arrs){
				   console.log("arrs = ", arrs);
		           $.each(arrs, function(index, num){
		        	   console.log("num = ", num);
		        	   let colName = "#col" + num;
		        	   console.log(colName);
		           
		        	   $(".col").remove(colName);
		           });
		          alert('공고가 삭제되었습니다.');
		          location.reload();
			   },
			   error : console.log
		   });
	   } else {
		   ckremove(annArr);
	   }
   }
   
   // ann 수정하기
   const editAnn = () => {
	   const annArr = Array.from(document.querySelectorAll('.card'));
	   // console.log(annArr);
	   const selectedArr = ckselected(annArr);

	   
	   if(selectedArr.length != 1){
		   alert('수정하시려면 하나의 공고만 선택해주세요.');
	   } else {
		   console.log(selectedArr[0]);
		   location.href=`/app/ann/annUpdate?annNo=\${selectedArr[0]}`;
	   }
	   
   }
   
   const ckselected = (annArr) => {
	   let annNo = 0;
	   let selectedArr = [];
	   let i = 0;
	   annArr.forEach((ann) => {
		   annNo = ann.firstElementChild.lastElementChild.value;
		   
		   if(ann.classList.contains("selected")){
			   selectedArr[i++] = annNo;
		   }
		   // element.classList.contains(class);
		   //if($(ann.currentTarget).hasClass("selected"))
	   });
	   
	   return selectedArr;
   }
   
   const ckremove = (annArr) => {
	   annArr.forEach((ann) => {
		   if(ann.classList.contains("selected")){
			   ann.classList.remove("selected");
		   }
	   });
   }
   
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