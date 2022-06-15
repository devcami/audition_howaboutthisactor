<%@page import="actor.model.dto.Actor"%>
<%@page import="actor.model.dto.ActorExt"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<ActorExt> list = (List<ActorExt>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
	String searchKeyword = request.getParameter("searchKeyword");
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<section id="ann-list-container">


	<div class="container">
		<div class="inner">
			
			
			<form action="<%= request.getContextPath() %>/ann/annFinder" id="annFinderFrm">
				<input type="text" name="searchKeyword" id="searchTitle" placeholder="제목을 검색해보세요!"
						value="<%= (searchKeyword != null) ? searchKeyword : "" %>" />
				<button class="btn-search-title">검색</button>
			</form>
		
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4" id="ann-container">
		<script> let a; </script>
		<% if(list != null && !list.isEmpty()){
			long miliseconds = System.currentTimeMillis();
			Date today = new Date(miliseconds); 
			for(int i = 0; i < list.size(); i++){ 
		%>
			 <div class="col">
			    <div class="card h-100 ann-card" onclick="actorSearch(this);">
					
					<div class="card-body">
						<h5 class="card-title"><%= list.get(i).getActorName() %></h5>
						<p class="card-text"><%= list.get(i).getMemberId() %></p>
						<input type="hidden" name="annNo" class="annNo" value="<%= list.get(i).getActorNo() %>" />
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
		<%= pagebar %>
	</div>
	
</section>
<script>

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>