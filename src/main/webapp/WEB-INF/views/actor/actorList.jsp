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

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/actorSearch.css"/>

<section id="ann-list-container">
<div class="top-logo">
  <span>배우를 찾아라!</span>
</div>

	<div class="container">
		<div class="inner">
			<div id="actorSearchFrm">
				<form action="<%= request.getContextPath() %>/actor/actorFinder">
					<input type="text" name="searchKeyword" id="searchTitle" placeholder="배우를 검색해보세요!"
						value="<%= (searchKeyword != null) ? searchKeyword : "" %>" />
					<button type="submit" class="btn-search-title">검색</button>
				</form>
			
			</div>
		<% if((loginMember != null) && (loginMember.getMemberRole() == MemberRole.P)) { %>
			<input type="button" value="포트폴리오등록" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath() %>/mypage/portfolio';" />
		<% } %>
		<br>
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4" id="ann-container">
		<script> let a; </script>
	<% if(list != null && !list.isEmpty()){
			for(int i = 0; i < list.size(); i++){ %>
			 <div class="col">
			    <div class="card h-100 ann-card" onclick="actorView(this);">
					<div class="card-body" id="cardBody">
						<span class="card-title"><%= list.get(i).getActorName() %></span> | 
						<span><%= list.get(i).getAge() %>세</span>
						<br />
						<span><%= list.get(i).getCompany() == null ? "" : list.get(i).getCompany() %></span>
						<br />
						<span><%= list.get(i).getHeight() == 0 ? "-" : list.get(i).getHeight() %>cm</span>
						<span><%= list.get(i).getWeight() == 0 ? "-" : list.get(i).getWeight() %>kg</span>
						<br />
						<% if(list.get(i).getAttachment().getRenamedFilename() != null) {%>
						 <img class="actor_photo" id="profile" src="<%= request.getContextPath() %>/upload/portfolio/<%= list.get(i).getAttachment().getRenamedFilename()%>">
						<% } %>
						<input type="hidden" name="actorNo" class="actorNo" value="<%= list.get(i).getActorNo() %>"/> 
					</div>
				</div>
			</div>
		<% } %>
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
	let actorNo = actor.firstElementChild.lastElementChild.value;
	location.href=`<%= request.getContextPath() %>/actor/actorView?actorNo=\${actorNo}`;
};
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>