<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Ann> list = (List<Ann>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<section id="ann-list-container">
	<div class="top-logo">
		<img src="<%= request.getContextPath() %>/images/annMain.jpeg" alt="공고페이지로고" />
	</div>
	<div class="container">
		<div class="inner">
			<select class="form-select" id="sortType" aria-label="Default select example">
			  <option class="sort-type" value="reg_date" id="reg_date" selected>최신순</option>
			  <option class="sort-type" value="end_date" id="end_date">마감순</option>
			</select>
			<input type="button" value="공고등록" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath() %>/ann/annEnroll';" />
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4" id="ann-container">

		</div>
	</div>
	<div class="btn-more d-grid gap-2 col-6 mx-auto">
		<button type="button" class="btn btn-secondary btn-lg" id="btn-more">더보기</button>
	</div>
	
</section>
<script>
document.querySelector("#btn-more").onclick = () => {
	
};
window.addEventListener('load', ()=>{
	morePage(1);
});
const morePage = (cPage) => {
	const container = document.querySelector("#ann-container");
	<%
	if(list != null && !list.isEmpty()){
		for(Ann ann : list){ %>
			let div = `
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
			  </div>`;
			  container.insertAdjacentHTML('beforeend', div);
	<% 	} %>
	<% } else { %>
			<div><p>조회된 공고가 없습니다.</p></div>
	<% } %>
};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>