<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	int totalPage = (int)request.getAttribute("totalPage");
	List<Ann> searchList = (List<Ann>) request.getAttribute("searchList");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<section id="ann-list-container">
	<div class="top-logo">
		<img src="<%= request.getContextPath() %>/images/annMain.jpeg" alt="" />
	</div>
	<div class="container">
<%-- 		<div class="search-ann">
			<!-- asynchronous? -->
			<form action="<%=request.getContextPath()%>/ann/annFinder">
				<input type="hidden" name="searchType" value="ann_title"/>
				<input type="text" name="searchKeyword" placeholder="검색 내용을 입력하세요." 
						value="<%= searchKeyword %>"/>
				<button>버튼이미지</button>
			</form>
		</div> --%>
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
	const cPageVal = Number(document.querySelector("#cPage").innerText) + 1;
	getRegDatePage(cPageVal);
};


const getRegDatePage = (cPage) => {
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/regDatePage",
		data : {cPage},	
		success(resp) {
			console.log(resp);
			
			const container = document.querySelector("#ann-container");
			resp.forEach((ann) => {
				const {annNo, memberId, annTitle, annRegDate, annEndDate} = ann;
				const div = `
				  <div class="col">
				    <div class="card h-100 ann-card">
						<div class="card-body">
							<h5 class="card-title">\${annTitle}</h5>
							<p class="card-text">\${memberId}</p>
							<input type="hidden" name="annNo" id="annNo" value=\${annNo} />
						</div>
						<div class="card-footer">
							<small class="text-muted">\${annRegDate}</small>~
							<small class="text-muted">\${annEndDate}</small>
						</div>
					</div>
				  </div>`;
				  container.insertAdjacentHTML('beforeend', div); 
				
			});
		},
		error : console.log,
		complete(){
			addEvent();
			if(cPage === <%= totalPage %>){
				const btn = document.querySelector("#btn-more");
				btn.disabled = "disabled";
				btn.style.cursor = "not-allowed";
			}
		}
	});
};

const addEvent = () => {
	document.querySelectorAll(".ann-card").forEach((ann) => {
		console.log(ann);
		ann.addEventListener('click', (e) => {
			console.log(e.target.lastElementChild.value);
			location.href=`<%= request.getContextPath() %>/ann/annView?annNo=\${e.target.lastElementChild.value}`;
		});
	});
}

window.addEventListener('load', () => {
	// 페이지 로딩 시 첫 페이지 요청
	getRegDatePage(1);
});


const sortType = document.querySelector("#sortType");
sortType.addEventListener('change', () => {
	document.querySelector("#ann-container").innerHTML = "";
	if(sortType.options[sortType.selectedIndex].value == 'end_date'){
		// 공고 마감순 선택 시 페이지 요청
		getEndDatePage(1);
	} else {
		// 공고 최신순 선택 시 페이지 요청
		getRegDatePage(1);
	}
});


const getEndDatePage = (cPage) => {
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/endDatePage",
		data : {cPage},	
		success(resp) {
			console.log(resp);
			
			const container = document.querySelector("#ann-container");
			resp.forEach((ann) => {
				const {no, memberId, annTitle, annRegDate, annEndDate} = ann;
				const div = `
				  <div class="col">
				    <div class="card h-100 ann-card">
						<div class="card-body">
							<h5 class="card-title">\${annTitle}</h5>
							<p class="card-text">\${memberId}</p>
						</div>
						<div class="card-footer">
							<small class="text-muted">\${annRegDate}</small> ~
							<small class="text-muted">\${annEndDate}</small>
						</div>
					</div>
				  </div>`;
				  container.insertAdjacentHTML('beforeend', div); 
			});
		},
		error : console.log,
		complete(){
			addEvent();
			if(cPage === <%= totalPage %>){
				const btn = document.querySelector("#btn-more");
				btn.disabled = "disabled";
				btn.style.cursor = "not-allowed";
			}
		}
	});
};

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>