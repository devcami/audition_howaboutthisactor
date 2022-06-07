<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Ann> list = (List<Ann>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<section id="ann-list-container">
	<div class="top-logo">
		<img src="<%= request.getContextPath() %>/images/annMain.jpeg" alt="공고페이지로고" />
	</div>
	<div class="container">
		<div class="inner">
			<select class="form-select" id="sortType" aria-label="Default select example">
			  <option class="sort-type" value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : ""%>>최신순</option>
			  <option class="sort-type" value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : ""%>>마감순</option>
			</select>
			<input type="button" value="공고등록" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath() %>/ann/annEnroll';" />
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4" id="ann-container">
		<% if(list != null && !list.isEmpty()){
		for(Ann ann : list){ %>
			 <div class="col">
			    <div class="card h-100 ann-card">
					<div class="card-body">
						<h5 class="card-title"><%= ann.getAnnTitle() %></h5>
						<p class="card-text"><%= ann.getMemberId() %></p>
						<input type="hidden" name="annNo" id="annNo" value="<%= ann.getAnnNo() %>" />
					</div>
					<div class="card-footer">
						<small class="text-muted"><%= ann.getAnnRegDate() %></small> ~ 
						<small class="text-muted"><%= ann.getAnnEndDate() %></small>
					</div>
				</div>
			  </div>
	<% 	} %>
	<% } else { %>
			<div><p>조회된 공고가 없습니다.</p></div>
	<% } %>
		</div>
	</div>
	<div id="pagebar">
		<%= pagebar %>
	</div>
	
</section>
<script>
sortType.addEventListener('change', (e) => {
	document.querySelector("#ann-container").innerHTML = "";
	const {value} = e.target;
	// 공고 마감순 선택 시 페이지 요청
	location.href=`<%= request.getContextPath() %>/ann/annList?sortType=\${value}`;
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>