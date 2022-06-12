<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/annEnroll.css" />
<%-- 작품정보섹션 --%>
<section id="ann-enroll-first">
	<div class="container">
		<div class="root">
			<div class="head-progressbar">
	          <ul class="progressbar">
	            <li class="active">작품 정보</li>
	            <li>작품 분야</li>
	            <li>담당자 정보</li>
	            <li>공고 리뷰</li>
	          </ul>
		    </div>
		</div>
		<h1>작품 정보</h1>
		<p class="description">작품에 대해 자세히 알려주세요.</p>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">작품 제목<span class="need">*</span></label> 
			<input type="text" name="title" class="form-control" id="exampleFormControlInput1" placeholder="ex. 기생충 (가제)">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput2" class="form-label">작품 분야<span class="need">*</span></label> 
			<select class="form-select" name="work_field" id="exampleFormControlInput2" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <optgroup label="영화">
				  <option value="lcf">장편 상업 영화</option>
				  <option value="lif">장편 독립 영화</option>
				  <option value="sf">단편 영화</option>
			  </optgroup>
			  <optgroup label="TV">
				  <option value="dr">드라마</option>
				  <option value="et">예능</option>
				  <option value="dc">다큐멘터리</option>
			  </optgroup>
			  <optgroup label="무대">
				  <option value="mu">뮤지컬</option>
				  <option value="pl">연극</option>
				  <option value="da">무용</option>
			  </optgroup>
			  <optgroup label="영상">
				  <option value="wd">웹드라마</option>
				  <option value="stm">인터넷 방송</option>
				  <option value="mv">뮤직 비디오</option>
			  </optgroup>
			  <optgroup label="광고">
				  <option value="ps">화보</option>
				  <option value="vAdv">영상 광고</option>
				  <option value="pAdv">사진 광고</option>
				  <option value="bAdv">바이럴 광고</option>
				  <option value="etcAdv">기타 광고</option>
				  <option value="lic">라이브 커머스</option>
			  </optgroup>
			  <optgroup label="기타">
				  <option value="etc">기타 사진 및 영상</option>
			  </optgroup>
			</select>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput3" class="form-label">감독 이름<span class="need">*</span></label> 
			<input type="text" name="director" class="form-control" id="exampleFormControlInput3" placeholder="ex. 봉준호">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput4" class="form-label">제작사<span class="need">*</span></label> 
			<input type="text" name="production" class="form-control" id="exampleFormControlInput4" placeholder="ex. 패러사이트 스튜디오">
		</div>
		<div class="mb-3 lastInput">
			<label for="exampleFormControlTextarea1" class="form-label">작품 설명</label>
			<a tabindex="0" id="btn-dscr" class="btn btn-sm btn-info" role="button" data-bs-toggle="popover" data-bs-trigger="focus" data-bs-content="배역과 관련된 정보는 다음페이지에서 적을 수 있어요. 시나리오나 작품에 대한 전반적인 정보를 알려주세요!">?</a>
			<textarea class="form-control" name="description" id="exampleFormControlTextarea1" rows="3" placeholder="ex. (300자 이내)상류층과 하류층, 두 가족의 만남을 다룬 대한민국의 블랙 코미디 가족 드라마 영화입니다."></textarea>
		</div>
		<hr />
		<h2>공고 마감일</h2>
		<p class="description">마감 날짜를 설정해주세요.</p>
		<input type="date" name="annAndDate" class="lastInput"/>
		<hr />
		<h2>추가 정보</h2>
		<p class="description">캐스팅 공고에 사진이나 영상을 추가할 수 있어요. (최대 5개)</p>
		<button id="btn-attach-add">파일 추가하기</button>
		<div class="mb-3" id="addAttachmentDiv">
		  <input class="form-control" type="file" name="attach1" id="attach1" multiple>
		</div>
		
		<button id="btn-next-enroll-page" onclick="location.href='<%= request.getContextPath() %>/ann/annEnrollSecond';" >다음</button>
	</div>
</section>
<section id="ann-enroll-second">
	<div class="container">
		<div class="mb-3">
			<h1>배역 정보</h1>
			<p>배역에 대해 자세히 알려주세요.</p>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">작품 제목<span class="need">*</span></label> 
			<input type="text" name="title" class="form-control" id="exampleFormControlInput1" placeholder="ex. 기생충 (가제)">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput2" class="form-label">작품 분야<span class="need">*</span></label> 
			<select class="form-select" name="work_field" id="exampleFormControlInput2" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <optgroup label="영화">
				  <option value="lcf">장편 상업 영화</option>
				  <option value="lif">장편 독립 영화</option>
				  <option value="sf">단편 영화</option>
			  </optgroup>
			  <optgroup label="TV">
				  <option value="dr">드라마</option>
				  <option value="et">예능</option>
				  <option value="dc">다큐멘터리</option>
			  </optgroup>
			  <optgroup label="무대">
				  <option value="mu">뮤지컬</option>
				  <option value="pl">연극</option>
				  <option value="da">무용</option>
			  </optgroup>
			  <optgroup label="영상">
				  <option value="wd">웹드라마</option>
				  <option value="stm">인터넷 방송</option>
				  <option value="mv">뮤직 비디오</option>
			  </optgroup>
			  <optgroup label="광고">
				  <option value="ps">화보</option>
				  <option value="vAdv">영상 광고</option>
				  <option value="pAdv">사진 광고</option>
				  <option value="bAdv">바이럴 광고</option>
				  <option value="etcAdv">기타 광고</option>
				  <option value="lic">라이브 커머스</option>
			  </optgroup>
			  <optgroup label="기타">
				  <option value="etc">기타 사진 및 영상</option>
			  </optgroup>
			</select>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput3" class="form-label">감독 이름<span class="need">*</span></label> 
			<input type="text" name="director" class="form-control" id="exampleFormControlInput3" placeholder="ex. 봉준호">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput4" class="form-label">제작사<span class="need">*</span></label> 
			<input type="text" name="production" class="form-control" id="exampleFormControlInput4" placeholder="ex. 패러사이트 스튜디오">
		</div>
		<div class="mb-3 lastInput">
			<label for="exampleFormControlTextarea1" class="form-label">작품 설명</label>
			<a tabindex="0" id="btn-dscr" class="btn btn-sm btn-info" role="button" data-bs-toggle="popover" data-bs-trigger="focus" data-bs-content="배역과 관련된 정보는 다음페이지에서 적을 수 있어요. 시나리오나 작품에 대한 전반적인 정보를 알려주세요!">?</a>
			<textarea class="form-control" name="description" id="exampleFormControlTextarea1" rows="3" placeholder="ex. (300자 이내)상류층과 하류층, 두 가족의 만남을 다룬 대한민국의 블랙 코미디 가족 드라마 영화입니다."></textarea>
		</div>
		<hr />
		<h2>공고 마감일</h2>
		<p class="description">마감 날짜를 설정해주세요.</p>
		<input type="date" name="annAndDate" class="lastInput"/>
		<hr />
		<h2>추가 정보</h2>
		<p class="description">캐스팅 공고에 사진이나 영상을 추가할 수 있어요. (최대 5개)</p>
		<button id="btn-attach-add">파일 추가하기</button>
		<div class="mb-3" id="addAttachmentDiv">
		  <input class="form-control" type="file" name="attach1" id="attach1" multiple>
		</div>
		
		<button id="btn-next-enroll-page" onclick="location.href='<%= request.getContextPath() %>/ann/annEnrollThird';" >다음</button>
	</div>
</section>
<script>
var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
});
<%-- 유효성검사 : * 항목 입력하지 않을 시 제출 방지 & description 300자 이상 작성 시 제출 방지 --%>
<%-- 작품 설명 300자이내 --%>
$(exampleFormControlTextarea1).keyup(function(e) {
	let content = $(this).val();
	if(content.length > 300){
		alert("작품 설명은 최대 300자까지 입력 가능합니다.");
		$(this).val(content.substring(0, 300));
		$(this).focus();
	}
});
const addAttachBtn = document.querySelector("#btn-attach-add");
$(addAttachBtn).click(function(){
    var lastAttachNo = $("#addAttachmentDiv input:last").attr("id").replace("attach", "");
    var newAttach = $("#addAttachmentDiv input:eq(0)").clone();
    newAttach.attr("id","attach"+(parseInt(lastAttachNo)+1));
    newAttach.attr("name","attach"+(parseInt(lastAttachNo)+1));
    console.log(newAttach);
    
    if(lastAttachNo == 5){
    	//첨부파일은 5개 이상 생성할수 없도록 제한
        alert("5개 이상 파일 추가 하실 수 없습니다.");
    } else {
    	$("#addAttachmentDiv").append(newAttach);
    }
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<%-- 
<section id="ann-enroll-second">
	<div class="container">
		<div class="mb-3">
			<h1>배역 정보</h1>
			<p>배역에 대해 자세히 알려주세요.</p>
			<label for="exampleFormControlInput" class="form-label">작품 제목</label> 
			<input type="text" class="form-control" placeholder="ex. 기생충 (가제)">
		</div>
	</div>
</section>

<section id="ann-enroll-third">
	<div class="container">
		<div class="mb-3">
			<h1>담당자 정보</h1>
			<p>담당자 대해 자세히 작성해주세요.</p>
			<label for="exampleFormControlInput1" class="form-label">작품 제목</label> 
			<input type="text" class="form-control" placeholder="ex. 기생충 (가제)">
		</div>
	</div>
</section>

<section id="ann-enroll-fourth">
	<div class="container">
		<div class="mb-3">
			<h1>공고 리뷰</h1>
			<p>공고 리뷰에 대한 내용입니다.</p>
			<label for="exampleFormControlInput1" class="form-label">작품 제목</label> 
			<input type="text" class="form-control" placeholder="ex. 기생충 (가제)">
		</div>
	</div>
</section> --%>