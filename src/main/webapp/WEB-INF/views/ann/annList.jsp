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
		    <div class="card h-100" id="ann-card">
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
	<nav class="pagebar" aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <li class="page-item disabled">
	    	<a class="page-link" href="#" aria-label="Previous">
	        	<span aria-hidden="true">&laquo;</span>
	     	</a>
	    </li>
	    <li class="page-item"><a class="page-link" href="#">1</a></li>
	    <li class="page-item"><a class="page-link" href="#">2</a></li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
	    <li class="page-item">
    		<a class="page-link" href="#" aria-label="Next">
    	    	<span aria-hidden="true">&raquo;</span>
      		</a>
	    </li>
	  </ul>
	</nav>
</section>
<script>
document.querySelector("#ann-card").onclick = (e) => {
	
};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>