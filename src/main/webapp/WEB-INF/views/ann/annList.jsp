<%@page import="member.model.dto.Production"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@page import="java.sql.Date"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	String sortType = request.getParameter("sortType");
	
	String searchKeyword = request.getParameter("searchKeyword");
	
	int totalPage = (int)request.getAttribute("totalPage");
	
%>

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
			  <option class="sort-type"  value="popular" id="popular" <%="popular".equals(sortType) ? "selected" : ""%>>인기순</option>
			</select>
			<div id="annFinderFrm">
				<input type="text" name="searchKeyword" id="searchTitle" placeholder="제목을 검색해보세요!"
						value="<%= (searchKeyword != null) ? searchKeyword : "" %>" />
				<button type="button" onclick="searchTitle();" class="btn-search-title">검색</button>
			</div>
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

		</div>
		<div id='btn-more-container'>
			<button id="btn-more" class="btn" type="button">더보기 (<span id="cPage"></span>/<span id="totalPage"><%= totalPage %></span>)</button>
		</div>
	</div>
</section>
<script>
document.querySelector("#btn-more").onclick = () => {
	const cPageVal = Number(document.querySelector("#cPage").innerText) + 1;
	getPage(cPageVal);
};


const annView = (ann) => {
	let annNo;
	annNo = ann.firstElementChild.lastElementChild.value;
	location.href=`<%= request.getContextPath() %>/ann/annView?annNo=\${annNo}`;
};
/*
 * 현재페이지
 */  
const getPage = (cPage) => {
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/morePage",
		data : {cPage},	
		success(resp) {
			const container = document.querySelector("#ann-container");
			let i = 1;
			if(cPage > 1){
				i = i * 12;
			}
			resp.forEach((ann) => {
				const {annNo, memberId, workNo, annTitle, annEndDate, annRegDate, isClose} = ann;
				const div = `
				<div class="col">
					<div class="card h-100 ann-card" id="annCard\${i}" onclick="annView(this);">
						<div class="card-body">
							<h5 class="card-title">\${annTitle}</h5>
							<p class="card-text">\${memberId}</p>
							<input type="hidden" name="annNo" class="annNo" value="\${annNo}" />
						</div>
						<div class="card-footer" id="cardFooter\${i}">
							<small class="text-muted">\${annRegDate}</small> ~ 
							<small class="text-muted">\${annEndDate}</small>
						</div>
					</div>
				</div>
				`;
				container.insertAdjacentHTML('beforeend', div); // 자식요소로 맨뒤에 추가
				const today = new Date();
				const endDate = new Date(annEndDate);
				const cardFooter = document.querySelector(`#cardFooter\${i}`);
				const annCard = document.querySelector(`#annCard\${i}`);
				if(endDate < today){
					cardFooter.insertAdjacentHTML('beforeend', '<small id="endAnn">&nbsp;! 모집마감 !</small>');
					cardFooter.classList.add("expFoot");
					annCard.classList.add("expirated")
				}
				i++;
			});
		},
		error : console.log,
		complete(){
			document.querySelector("#cPage").innerHTML = cPage;
		
			if(cPage === <%= totalPage %>){
				const btn = document.querySelector("#btn-more")
				btn.disabled = "disabled";
				btn.style.cursor = "not-allowed";
				
			}
		}
	});
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
		success(resp){
			
			const container = document.querySelector("#ann-container");
			let i = 1;
			if(cPage > 1){
				i = i * 12;
			}
			while(container.hasChildNodes()){
				container.removeChild(container.firstChild);
			}
			resp.forEach((ann) => {
				const {annNo, memberId, workNo, annTitle, annEndDate, annRegDate, isClose} = ann;
				const div = `
				<div class="col">
					<div class="card h-100 ann-card" id="annCard\${i}" onclick="annView(this);">
						<div class="card-body">
							<h5 class="card-title">\${annTitle}</h5>
							<p class="card-text">\${memberId}</p>
							<input type="hidden" name="annNo" class="annNo" value="\${annNo}" />
						</div>
						<div class="card-footer" id="cardFooter\${i}">
							<small class="text-muted">\${annRegDate}</small> ~ 
							<small class="text-muted">\${annEndDate}</small>
						</div>
					</div>
				</div>
				`;
				container.insertAdjacentHTML('beforeend', div); // 자식요소로 맨뒤에 추가
				const today = new Date();
				const endDate = new Date(annEndDate);
				const cardFooter = document.querySelector(`#cardFooter\${i}`);
				const annCard = document.querySelector(`#annCard\${i}`);
				if(endDate < today){
					cardFooter.insertAdjacentHTML('beforeend', '<small id="endAnn">&nbsp;! 모집마감 !</small>');
					cardFooter.classList.add("expFoot");
					annCard.classList.add("expirated")
				}
				i++;
			});
			
		},
		error : console.log,
		complete() {
			document.body.style = "";
			const oc = document.querySelector("#offcanvasRight");
			oc.style.visibility = "hidden";
			oc.classList.remove("show");
			oc.removeAttribute("aria-modal");
			oc.removeAttribute("role");
			oc.setAttribute("aria-hidden", "true");
			
			const ob = document.querySelector(".inner");
			ob.removeChild(ob.lastChild);
			
			document.querySelectorAll("[name=annGender]").forEach((e) =>{
				if(e.checked) e.checked = false;
			}); 
			document.querySelectorAll("[name=annAge]").forEach((select) => {
				Array.from(select.children).forEach((e) => {
					if(e.selected) e.selected = '선택해주세요';
				});
			});
			document.querySelectorAll("[name=annHeight]").forEach((select) => {
				Array.from(select.children).forEach((e) => {
					if(e.selected) e.selected = '선택해주세요';
				});
			});
			document.querySelectorAll("[name=annBody]").forEach((select) => {
				Array.from(select.children).forEach((e) => {
					if(e.selected) e.selected = '선택해주세요';
				});
			});
			
		}
	});
}

<%-- 최신순(default) | 마감순 | 인기순 정렬 --%>
sortType.addEventListener('change', (e) => {
	const {value} = e.target;
	document.querySelector("#ann-container").innerHTML = "";
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/annListSort",
		data : {
			sortType : value
		},
		success(resp){
			const container = document.querySelector("#ann-container");
			let i = 1;
			if(cPage > 1){
				i = i * 12;
			}
			while(container.hasChildNodes()){
				container.removeChild(container.firstChild);
			}
			resp.forEach((ann) => {
				const {annNo, memberId, workNo, annTitle, annEndDate, annRegDate, isClose} = ann;
				const div = `
				<div class="col">
					<div class="card h-100 ann-card" id="annCard\${i}" onclick="annView(this);">
						<div class="card-body">
							<h5 class="card-title">\${annTitle}</h5>
							<p class="card-text">\${memberId}</p>
							<input type="hidden" name="annNo" class="annNo" value="\${annNo}" />
						</div>
						<div class="card-footer" id="cardFooter\${i}">
							<small class="text-muted">\${annRegDate}</small> ~ 
							<small class="text-muted">\${annEndDate}</small>
						</div>
					</div>
				</div>
				`;
				container.insertAdjacentHTML('beforeend', div); // 자식요소로 맨뒤에 추가
				const today = new Date();
				const endDate = new Date(annEndDate);
				const cardFooter = document.querySelector(`#cardFooter\${i}`);
				const annCard = document.querySelector(`#annCard\${i}`);
				if(endDate < today){
					cardFooter.insertAdjacentHTML('beforeend', '<small id="endAnn">&nbsp;! 모집마감 !</small>');
					cardFooter.classList.add("expFoot");
					annCard.classList.add("expirated")
				}
				i++;
			});
			
		},
		error : console.log
	});

});


<%-- 제목으로 검색 --%>
const searchTitle = () => {
	const {value} = document.querySelector('#searchTitle');
	document.querySelector("#ann-container").innerHTML = "";
	$.ajax({
		url : "<%= request.getContextPath() %>/ann/annFinder",
		data : {
			searchKeyword : value
		},
		success(resp){
			const container = document.querySelector("#ann-container");
			let i = 1;
			if(cPage > 1){
				i = i * 12;
			}
			while(container.hasChildNodes()){
				container.removeChild(container.firstChild);
			}
			resp.forEach((ann) => {
				const {annNo, memberId, workNo, annTitle, annEndDate, annRegDate, isClose} = ann;
				const div = `
				<div class="col">
					<div class="card h-100 ann-card" id="annCard\${i}" onclick="annView(this);">
						<div class="card-body">
							<h5 class="card-title">\${annTitle}</h5>
							<p class="card-text">\${memberId}</p>
							<input type="hidden" name="annNo" class="annNo" value="\${annNo}" />
						</div>
						<div class="card-footer" id="cardFooter\${i}">
							<small class="text-muted">\${annRegDate}</small> ~ 
							<small class="text-muted">\${annEndDate}</small>
						</div>
					</div>
				</div>
				`;
				container.insertAdjacentHTML('beforeend', div); // 자식요소로 맨뒤에 추가
				const today = new Date();
				const endDate = new Date(annEndDate);
				const cardFooter = document.querySelector(`#cardFooter\${i}`);
				const annCard = document.querySelector(`#annCard\${i}`);
				if(endDate < today){
					cardFooter.insertAdjacentHTML('beforeend', '<small id="endAnn">&nbsp;! 모집마감 !</small>');
					cardFooter.classList.add("expFoot");
					annCard.classList.add("expirated")
				}
				i++;
			});
			
		},
		error : console.log
	});
};


window.addEventListener('load', () => {
	// 페이지 로딩 시 첫 페이지 요청
	getPage(1);
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>