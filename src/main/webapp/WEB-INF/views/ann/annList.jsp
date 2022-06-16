<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
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
	
	String searchKeyword = request.getParameter("searchKeyword");
%>

<script>
<%-- 상세검색 비동기 --%>
const detailFinder = () => {
	let gender;
	let age;
	let height;
	let body;
	document.querySelectorAll("[name=annGender]").forEach((e) =>{
		if(e.checked){
			gender = e.value;
		}
	}); 
	document.querySelectorAll("[name=annAge]").forEach((select) => {
		Array.from(select.children).forEach((e) => {
			if(e.selected){
				if(e.value != '선택해주세요')
					age = e.value;
			}			
		});
	});
	document.querySelectorAll("[name=annHeight]").forEach((select) => {
		Array.from(select.children).forEach((e) => {
			if(e.selected){
				if(e.value != '선택해주세요') 
					height = e.value;
			}			
		});
	});
	document.querySelectorAll("[name=annBody]").forEach((select) => {
		Array.from(select.children).forEach((e) => {
			if(e.selected){
				if(e.value != '선택해주세요')
					body = e.value;
			}			
		});
	});
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/annDFinder",
		data : {
			annGender : gender,
			annAge : age,
			annHeight : height,
			annBody : body
		},
		success(annList){
			
			
		},
		error : console.log
	});
}
</script>


<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<section id="ann-list-container">
	<div class="top-logo">
		<img src="<%= request.getContextPath() %>/images/annMain.jpeg" alt="공고페이지로고" />
	</div>
	<div class="container">
		<div class="inner">
			<select class="form-select" id="sortType" aria-label="Default select example">
			  <option class="sort-type"  value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : ""%>>최신순</option>
			  <option class="sort-type"  value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : ""%>>마감순</option>
			</select>
			<form action="<%= request.getContextPath() %>/ann/annFinder" id="annFinderFrm">
				<input type="text" name="searchKeyword" id="searchTitle" placeholder="제목을 검색해보세요!"
						value="<%= (searchKeyword != null) ? searchKeyword : "" %>" />
				<button class="btn-search-title">검색</button>
			</form>
			
			<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
			  <div class="offcanvas-header">
			    <h2 id="offcanvasRightLabel">상세검색</h2>
			    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
			  </div>
			  <div class="offcanvas-body" id="annDetailFinderFrm">
	  				<div class="mb-3" id="dfGender">
						<label for="dfGender" class="form-label">성별</label> 
						<div class="form-check">
							<input class="form-check-input" type="radio" value="성별무관" name="annGender" id="flexRadioDefault1"> 
							<label class="form-check-label" for="flexRadioDefault1">성별무관</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" value="남" name="annGender" id="flexRadioDefault2"> 
							<label class="form-check-label" for="flexRadioDefault2">남</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" value="여" name="annGender" id="flexRadioDefault3"> 
							<label class="form-check-label" for="flexRadioDefault3">여</label>
						</div>
					</div>
					<div class="mb-3" id="dfAge">
						<label for="dfAge" class="form-label">나이</label> 
						<select class="form-select" name="annAge" aria-label="Default select example">
						  <option selected disabled>선택해주세요</option>
						  <option value="나이무관">나이무관</option>
						  <option value="10세">~10세</option>
						  <option value="11~17세">11~17세</option>
						  <option value="18~25세">18~25세</option>
						  <option value="26~35세">26~35세</option>
						  <option value="36~45세">36~45세</option>
						  <option value="45세~">45세~</option>
						</select>
					</div>
					<div class="mb-3" id="dfHeight">
						<label for="dfHeight" class="form-label">키</label> 
						<select class="form-select" name="annHeight" aria-label="Default select example">
						  <option selected disabled>선택해주세요</option>
						  <option value="신장무관">신장무관</option>
						  <option value="~110cm">~110cm</option>
						  <option value="111~150cm">111~150cm</option>
						  <option value="151~160cm">151~160cm</option>
						  <option value="161~170cm">161~170cm</option>
						  <option value="171~180cm">171~180cm</option>
						  <option value="180cm~">180cm~</option>
						</select>
					</div>
					<div class="mb-3" id="dfWeight">
						<label for="dfWeight" class="form-label">체형</label> 
						<select class="form-select" name="annBody" id="exampleFormControlInput11" aria-label="Default select example">
						  <option selected disabled> 선택해주세요</option>
						  <option value="평균">평균</option>
						  <option value="마름">마름</option>
						  <option value="탄탄함">탄탄함</option>
						  <option value="근육질의">근육질의</option>
						  <option value="글래머러스함">글래머러스함</option>
						  <option value="다부짐">다부짐</option>
						  <option value="통통함">통통함</option>
						  <option value="뚱뚱함">뚱뚱함</option>
						</select>
					</div>
					<button class="btn-search-detail" onclick="detailFinder();">검색</button>
			  </div>
			</div>
			<button type="button" class="btn btn-primary btn-lg" id="btn-detail-search" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">상세검색</button>
		<% if((loginMember != null) && (loginMember.getMemberRole() == MemberRole.D)) { %>
			<input type="button" value="공고등록" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath() %>/ann/annEnroll';" />
		<% } %>
		</div>
		<div class="row row-cols-1 row-cols-md-3 g-4" id="ann-container">
		<script> let a; </script>
		<% if(list != null && !list.isEmpty()){
			long miliseconds = System.currentTimeMillis();
			Date today = new Date(miliseconds); 
			for(int i = 0; i < list.size(); i++){ 
		%>
			 <div class="col">
			    <div class="card h-100 ann-card" onclick="annView(this);">
					<% if(list.get(i).getAnnEndDate().before(today)){ %>
						<script>
						    a = Array.from(this.$(".ann-card"));
						    a.at(-1).classList.add('expirated')
						</script>
					<% } %>
					<div class="card-body">
						<h5 class="card-title"><%= list.get(i).getAnnTitle() %></h5>
						<p class="card-text"><%= list.get(i).getMemberId() %></p>
						<input type="hidden" name="annNo" class="annNo" value="<%= list.get(i).getAnnNo() %>" />
					</div>
					<div class="card-footer" id="<%= list.get(i).getAnnEndDate().before(today) ? "expFoot" : "" %>">
						<small class="text-muted"><%= list.get(i).getAnnRegDate() %></small> ~ 
						<small class="text-muted"><%= list.get(i).getAnnEndDate() %></small>
					<% if(list.get(i).getAnnEndDate().before(today)){ %>
						<small id="endAnn">&nbsp;! 모집마감 !</small>
					<% } %>
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
	location.href=`<%= request.getContextPath() %>/ann/annEndDateList?sortType=\${value}`;
});
const annView = (ann) => {
	let annNo;
	if(ann.classList.contains("expirated")){
		annNo = ann.firstElementChild.nextElementSibling.lastElementChild.value;
	}
	else{
		annNo = ann.firstElementChild.lastElementChild.value;
	}
	location.href=`<%= request.getContextPath() %>/ann/annView?annNo=\${annNo}`;
};

<%-- 상세검색 비동기 --%>
const detailFinder = () => {
	let gender;
	let age;
	let height;
	let body;
	document.querySelectorAll("[name=annGender]").forEach((e) =>{
		if(e.checked){
			gender = e.value;
		}
	}); 
	document.querySelectorAll("[name=annAge]").forEach((select) => {
		Array.from(select.children).forEach((e) => {
			if(e.selected){
				if(e.value != '선택해주세요')
					age = e.value;
			}			
		});
	});
	document.querySelectorAll("[name=annHeight]").forEach((select) => {
		Array.from(select.children).forEach((e) => {
			if(e.selected){
				if(e.value != '선택해주세요') 
					height = e.value;
			}			
		});
	});
	document.querySelectorAll("[name=annBody]").forEach((select) => {
		Array.from(select.children).forEach((e) => {
			if(e.selected){
				if(e.value != '선택해주세요')
					body = e.value;
			}			
		});
	});
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/annDFinder",
		data : {
			annGender : gender,
			annAge : age,
			annHeight : height,
			annBody : body
		},
		success(annList){
			console.log(annList);
						
		},
		error : console.log
	});
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>