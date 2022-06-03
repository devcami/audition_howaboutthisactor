<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<section id="ann-list-container">
	<div class="top-logo">
		<img src="<%= request.getContextPath() %>/images/annMain.jpeg" alt="" />
	</div>
	<div class="container">
		<div class="inner">
			<select class="form-select" aria-label="Default select example">
			  <option value="1" selected>최신순</option>
			  <option value="2">마감순</option>
			</select>
			<input type="button" value="공고등록" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath() %>/ann/annEnroll';" />
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4">
		<% for(int i = 0; i < 12; i++){ %>
		  <div class="col">
		    <div class="card h-100 ann-card">
				<div class="card-body">
					<h5 class="card-title">공고 제목</h5>
					<p class="card-text">공고 작성자</p>
				</div>
				<div class="card-footer">
					<small class="text-muted">등록 날짜</small>
				</div>
			</div>
		  </div>
		 <% } %>
		</div>
	</div>
	<div class="btn-more d-grid gap-2 col-6 mx-auto">
		<button type="button" class="btn btn-secondary btn-lg" id="btn-more">더보기</button>
	</div>
	
</section>
<script>
<%-- 공고 클릭 시 공고 상세보기 --%>
const annList = document.querySelectorAll(".ann-card").forEach((ann) => {
	ann.onclick = (e) => {
		location.href="<%= request.getContextPath() %>/ann/annView?no=1"
	};
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>