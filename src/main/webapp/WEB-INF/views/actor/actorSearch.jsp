<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<ActorInfo> list = (List<ActorInfo>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");

	String searchKeyword = request.getParameter("searchKeyword");
	
%>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/actor.css"/>

<section id="ann-list-container">
<div class="top-logo">
  <span>배우를 찾아라!</span>
</div>

	<div class="container">
		<div class="inner">
			
			
			<form action="<%= request.getContextPath() %>/mypage/actorInfo" id="annFinderFrm">
				<input type="text" name="searchKeyword" id="searchTitle" placeholder=" 배우를 검색하세요."
						value="<%= (searchKeyword != null) ? searchKeyword : "" %>" />
				<button class="btn-search-title">검색</button>
			</form>
		<br>
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4" id="ann-container">
		<script> let a; </script>
		<% if(list != null && !list.isEmpty()){
			long miliseconds = System.currentTimeMillis();
			Date today = new Date(miliseconds); 
			for(int i = 0; i < list.size(); i++){ 
		%>
			 <div class="col">
			    <div class="card h-100 ann-card" onclick="actorView(this);">
					
					<div class="card-body <%= request.getContextPath() %>/actor/actorView">
						<h5 class="card-title"><%= list.get(i).getActorName() %></h5>
						<p class="card-text"><%= list.get(i).getMemberId() %></p>
						 <img class="actor_photo" src="<%= request.getContextPath() %>/upload/portfolio/<%= list.get(i).getAttachment().getRenamedFilename()%>">
						<input type="hidden" name="annNo" class="annNo" value="<%= list.get(i).getActorNo() %>"/> 
						
					</div>
					
				</div>
			  </div>
	<% 	} %>
	<% } else { %>
			<div><p>조회된 배우가 없습니다.</p></div>
	<% } %>
		</div>
	</div>
	<div id="pagebar">
		<%= request.getAttribute("pagebar") %>
	</div>
	
</section>
<script>
const actorView = (actor) => {
	   let actorNo;
	   actorNo = actor.firstElementChild.lastElementChild.value;
	   location.href=`<%= request.getContextPath() %>/actor/actorView?actor=\${actorNo}`;
	};
const getPage = (cPage) => {
	   $.ajax({
	      url : "<%= request.getContextPath() %>/actor/",
	      data : {cPage},   
	      success(resp) {
	         const container = document.querySelector("#ann-container");
	         let i = 1;
	         if(cPage > 1){
	            i = i * 12;
	         }
	         
	         resp.forEach((actorinfo) => {
	            const {memberId, actor_name, actor_no, birth, actor_age, education, height, weight,company,phone,email,speciality,sns,attach_no} = actorinfo;
	            const div = `
	            <div class="col">
	               <div class="card h-100 ann-card" id="annCard\${i}" onclick="actorView(this);">
	                  <div class="card-body">
	                     <h5 class="card-title">\${actorTitle}</h5>
	                     <p class="card-text">\${memberId}</p>
	                     <input type="hidden" name="actorNo" class="actorNo" value="\${actorNo}" />
	                  </div>
	                 /*  <div class="card-footer" id="cardFooter\${i}">
	                     <small class="text-muted">\${annRegDate}</small> ~ 
	                     <small class="text-muted">\${annEndDate}</small>
	                  </div> */
	               </div>
	            </div>
	            `;
	            container.insertAdjacentHTML('beforeend', div); // 자식요소로 맨뒤에 추가
	            const today = new Date();
	           /*  const endDate = new Date(annEndDate);
	            const cardFooter = document.querySelector(`#cardFooter\${i}`);
	            const annCard = document.querySelector(`#annCard\${i}`); */
	            }
	            i++;
	         });
	      },
	      error : console.log,
	      complete(){
	         document.querySelector("#cPage").innerHTML = cPage;
	         }
	      }
	   });
	};
	</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>