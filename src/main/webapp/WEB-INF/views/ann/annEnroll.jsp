<%@page import="member.model.dto.Production"%>
<%@page import="java.sql.Date"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	Date birthday = Date.valueOf("1990-09-09");
	Date enrollDate = Date.valueOf("2022-06-10");
	Member loginMember = new Member("director", "1234", "디렉터샘플", "director@naver.com", MemberRole.D, "01015971597", "M", birthday, enrollDate);
	Production p = new Production("director", "testProduction", "디렉터", "01015971597", "director@naver.com", "N", "N");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/annEnroll.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<form 
	id = "annEnrollFrm" 
	name = "annEnrollFrm" 
	method = "post" 
	action = "<%= request.getContextPath() %>/ann/annEnroll"
	enctype="multipart/form-data">
<%-- 작품정보섹션 --%>
<section id="ann-enroll-first">
	<div class="container">
		<h1>작품 정보</h1>
		<p class="description">작품에 대해 자세히 알려주세요.</p>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">작품 제목<span class="need">*</span></label> 
			<input type="text" name="title" value="기생충" class="form-control" id="exampleFormControlInput1" placeholder="ex. 기생충 (가제)">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput2" class="form-label">작품 분야<span class="need">*</span></label> 
			<select class="form-select" name="workField" id="exampleFormControlInput2" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <optgroup label="영화">
				  <option value="lcf" selected>장편 상업 영화</option>
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
			<input type="text" name="director" value="봉준호" class="form-control" id="exampleFormControlInput3" placeholder="ex. 봉준호">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput4" class="form-label">제작사<span class="need">*</span></label> 
			<input type="text" name="production" value="패스튜디오" class="form-control" id="exampleFormControlInput4" placeholder="ex. 패러사이트 스튜디오">
		</div>
		<div class="mb-3 lastInput">
			<label for="exampleFormControlTextarea1" class="form-label">작품 설명</label>
			<a tabindex="0" id="btn-dscr" class="btn btn-sm btn-info" role="button" data-bs-toggle="popover" data-bs-trigger="focus" data-bs-content="배역과 관련된 정보는 다음페이지에서 적을 수 있어요. 시나리오나 작품에 대한 전반적인 정보를 알려주세요!">?</a>
			<textarea class="form-control" name="description" id="exampleFormControlTextarea1" rows="3" placeholder="ex. (300자 이내)상류층과 하류층, 두 가족의 만남을 다룬 대한민국의 블랙 코미디 가족 드라마 영화입니다.">어쩌구</textarea>
		</div>
		<hr />
		<h2>공고 마감일</h2>
		<p class="description">마감 날짜를 설정해주세요.</p>
		<p class="description">오늘 이후의 날짜만 설정 가능합니다.</p>
		<input type="text" name="annEndDate" value="2022-06-22" id="annEndDate" class="lastInput"/><span class="need">*</span>
		<hr />
		<h2>추가 정보</h2>
		<p class="description">캐스팅 공고에 사진이나 영상을 추가할 수 있어요. (최대 5개)</p>
		<button type="button" id="btn-attach-add" class="btn btn-primary">파일 추가하기</button>
		<div class="mb-3" id="addAttachmentDiv">
		  <input class="form-control" type="file" name="attach1" id="attach1" multiple>
		</div>
		
		<button type="button" id="btn-first-enroll" class="btn-next" onclick="nextStep(this);" >다음</button>
	</div>
</section>

<%-- 배역 정보 섹션 --%>
<section id="ann-enroll-second">
	<div class="container">
		<div class="mb-3">
			<h1>배역 정보</h1>
			<p class="description">배역의 정보를 구체적으로 입력할수록 캐스팅 성공률이 높아집니다!</p>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput5" class="form-label">배역 이름<span class="need">*</span></label> 
			<input type="text" name="castName" value="김기택" class="form-control" id="exampleFormControlInput5" placeholder="ex. 김기택, 편의점 알바생 등">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput6" class="form-label">배역 구분<span class="need">*</span></label> 
			<select class="form-select" name="castRole" id="exampleFormControlInput6" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <option value="lead" selected>주연</option>
			  <option value="sup">조연</option>
			  <option value="minor">단역</option>
			  <option value="extra">엑스트라</option>
			</select>
		   <input class="form-check-input" type="checkbox" name="hasTO" value="" id="flexCheckDefault">
		   <label class="form-check-label" for="flexCheckDefault">노출장면 포함</label>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput7" class="form-label">성별<span class="need">*</span></label> 
			<div class="form-check">
				<input class="form-check-input" type="radio" name="annGender" value="성별무관" id="flexRadioDefault1" checked> 
				<label class="form-check-label" for="flexRadioDefault1">성별무관</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="annGender" value="남" id="flexRadioDefault2"> 
				<label class="form-check-label" for="flexRadioDefault2">남</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="annGender" value="여" id="flexRadioDefault3"> 
				<label class="form-check-label" for="flexRadioDefault3">여</label>
			</div>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput8" class="form-label">나이<span class="need">*</span></label> 
			<select class="form-select" name="annAge" id="exampleFormControlInput8" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <option value="age" selected>나이무관</option>
			  <option value="1">~10세</option>
			  <option value="10">11~17세</option>
			  <option value="20">18~25세</option>
			  <option value="30">26~35세</option>
			  <option value="40">36~45세</option>
			  <option value="50">45세~</option>
			</select>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput9" class="form-label">모집 인원<span class="need">*</span></label> <br>
			<input type="text" name="annNop" class="form-control" id="exampleFormControlInput9"> 명
		</div>
		<h2>배역 추가 정보</h2>
		<div class="mb-3">
			<label for="exampleFormControlInput10" class="form-label">키</label> 
			<select class="form-select" name="annHeight" id="exampleFormControlInput10" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <option value="age" selected>신장무관</option>
			  <option value="110">~110cm</option>
			  <option value="150">111~150cm</option>
			  <option value="160">151~160cm</option>
			  <option value="170">161~170cm</option>
			  <option value="180">171~180cm</option>
			  <option value="190">180cm~</option>
			</select>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput11" class="form-label">체형</label> 
			<select class="form-select" name="annBody" id="exampleFormControlInput11" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <option value="평균">평균</option>
			  <option value="마름" selected>마름</option>
			  <option value="탄탄함">탄탄함</option>
			  <option value="근육질의">근육질의</option>
			  <option value="글래머러스함">글래머러스함</option>
			  <option value="다부짐">다부짐</option>
			  <option value="통통함">통통함</option>
			  <option value="뚱뚱함">뚱뚱함</option>
			</select>
		</div>
		<div class="mb-3 lastInput">
			<label for="exampleFormControlTextarea2" class="form-label">배역 설명</label>
			<textarea class="form-control" name="castContents" id="exampleFormControlTextarea2" rows="5" placeholder="ex. (300자 이내) 운전 기사 역할로 어떤 상황에서도 느긋하고 늘어지는 성격을 가지고 있으며 자기합리화를 잘 하는 인물입니다. 승용차 운전과 흡연이 가능하신 분만 지원해주세요.">55</textarea>
		</div>
		<hr />
		<h2>촬영 정보 및 출연료</h2>
		<p class="description">대략적인 촬영 정보와 출연료를 입력해주세요.</p>
		<div class="mb-3">
			<label for="exampleFormControlInput12" class="form-label">촬영 지역</label> 
			<select class="form-select" name="annArea" id="exampleFormControlInput12" aria-label="Default select example">
			  <option selected>선택해주세요</option>
			  <option value="서울">서울</option>
			  <option value="경기">경기</option>
			  <option value="인천">인천</option>
			  <option value="강원">강원</option>
			  <option value="충북">충북</option>
			  <option value="충남">충남</option>
			  <option value="전북">전북</option>
			  <option value="전남">전남</option>
			  <option value="경북">경북</option>
			  <option value="경남">경남</option>
			  <option value="울산">울산</option>
			  <option value="부산">부산</option>
			  <option value="광주">광주</option>
			  <option value="대전">대전</option>
			  <option value="대구">대구</option>
			  <option value="세종">세종</option>
			  <option value="제주">제주</option>
			</select>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput13" class="form-label">출연료<span class="need">*</span></label> <br>
			<input type="text" name="annPay" class="form-control" id="exampleFormControlInput13" placeholder="ex. 회당 10만원 총 10회">
		</div>
		<button type="button" id="btn-second-enroll" class="btn-next" onclick="nextStep(this);">다음</button>
	</div>
</section>
<section id="ann-enroll-third">
	<div class="container">
		<h1>담당자 정보</h1>
		<p class="description">연락처를 공개하면 지원자들로부터 많은 문의를 받을 수도 있습니다.</p>
		<div class="mb-3">
			<label for="exampleFormControlInput14" class="form-label">담당자 이름</label> 
			<p class="description">공고에서 담당자 이름은 기본적으로 공개됩니다.</p>
			<input type="text" class="form-control" name="casterName" id="exampleFormControlInput14" value="<%= p.getCasterName() %>" readonly> 
			<input type="hidden" class="form-control" name="casterPhone" id="exampleFormControlInput15" value="<%= p.getCasterPhone() %>"> 
			<input type="hidden" class="form-control" name="casterEmail" id="exampleFormControlInput16" value="<%= p.getCasterEmail() %>"> 
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput15" class="form-label">담당자 휴대폰 번호</label> 
			<div class="form-check">
				<input class="form-check-input" type="radio" name="isPhoneOpen" value="Y" id="flexRadioDefault4"> 
				<label class="form-check-label" for="flexRadioDefault4">공개</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="isPhoneOpen" value="N" id="flexRadioDefault5" checked> 
				<label class="form-check-label" for="flexRadioDefault5">비공개</label>
			</div>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput16" class="form-label">담당자 이메일</label> 
			<div class="form-check">
				<input class="form-check-input" type="radio" name="isEmailOpen" value="Y" id="flexRadioDefault6"> 
				<label class="form-check-label" for="flexRadioDefault6">공개</label>
			</div>
			<div class="form-check">
				<input class="form-check-input" type="radio" name="isEmailOpen" value="N" id="flexRadioDefault7" checked> 
				<label class="form-check-label" for="flexRadioDefault7">비공개</label>
			</div>
		</div>
		<hr />
		<%-- 개별문의 수신 여부 / 신규 지원자 이메일 알림 -> 보류 --%>
		<button id="btn-submit-enroll" class="btn-submit" type="submit" onclick="enrollSubmit(this);">제출</button>
	</div>
</section>
</form>
<script>
<%-- 상단 프로그레스바 --%>
<%-- 유효성검사 : * 항목 입력하지 않을 시 제출 방지 & description 300자 이상 작성 시 제출 방지 --%>
// 필수항목 입력
document.annEnrollFrm.onsubmit = (e) => {
	const f = e.target;
	// 작품 제목
	const titleVal = f.title.value.trim();
	if(!/^.+$/.test(titleVal)){
		console.log(titleVal)
		alert('제목을 작성해주세요.');
		f.title.select();
		return false;
	}
	// 작품 분야
	const workFieldVal = f.workField.value.trim();
	if(!/^.+$/.test(workFieldVal)){
		alert('작품 분야를 선택해주세요.');
		f.workField.select();
		return false;
	}
	// 감독 이름
	const directorVal = f.director.value.trim();
	if(!/^.+$/.test(directorVal)){
		alert('감독 이름을 작성해주세요.');
		f.director.select();
		return false;
	}
	// 제작사
	const productionVal = f.production.value.trim();
	if(!/^.+$/.test(productionVal)){
		alert('제작사를 작성해주세요.');
		f.production.select();
		return false;
	}
	// 공고 마감일
	const annEndDateVal = f.annEndDate.value.trim();
	if(!/^.+$/.test(annEndDateVal)){
		alert('마감 날짜를 선택해주세요.');
		f.annEndDate.select();
		return false;
	}
	// 배역 이름
	const castNameVal = f.castName.value.trim();
	if(!/^.+$/.test(castNameVal)){
		alert('배역 이름을 작성해주세요.');
		f.castName.select();
		return false;
	}
	// 배역 구분
	const castRoleVal = f.castRole.value.trim();
	if(!/^.+$/.test(castRoleVal)){
		alert('배역 구분을 선택해주세요.');
		f.castRole.select();
		return false;
	}
	// 성별
	const annGenderVal = f.annGender.value.trim();
	if(!/^.+$/.test(annGenderVal)){
		alert('성별을 선택해주세요.');
		f.annGender.select();
		return false;
	}
	// 나이
	const annAgeVal = f.annAge.value.trim();
	if(!/^.+$/.test(annAgeVal)){
		alert('나이를 선택해주세요.');
		f.annAge.select();
		return false;
	}
	// 모집 인원 숫자만 가능
	const annNopVal = f.annNop.value.trim();
	if(!/^[0-9]+$/.test(annNopVal)){
		alert('모집인원을 숫자로 작성해주세요.');
		f.annNop.select();
		return false;
	}
	// 출연료
	const annPayVal = f.annPay.value.trim();
	if(!/^.+$/.test(annPayVal)){
		alert('나이를 선택해주세요.');
		f.annPay.select();
		return false;
	}
	return true;
};

// 마감날짜가 오늘날짜보다 작을 시 선택 불가
$(document).ready(function () {
    $.datepicker.setDefaults($.datepicker.regional['ko']); 
    $(annEndDate).datepicker({
         changeMonth: true, 
         changeYear: true,
         nextText: '다음 달',
         prevText: '이전 달', 
         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         dateFormat: "yy-mm-dd",
         minDate: 1,
         onClose: function( selectedDate ) {    
              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
             $("#endDate").datepicker( "option", "minDate", selectedDate );
         }    
    });
});

// 작품 설명, 배역 설명 300자이내
$(exampleFormControlTextarea1).keyup(function(e) {
	let content = $(this).val();
	if(content.length > 300){
		alert("작품 설명은 최대 300자까지 입력 가능합니다.");
		$(this).val(content.substring(0, 300));
		$(this).focus();
	}
});
$(exampleFormControlTextarea2).keyup(function(e) {
	let content = $(this).val();
	if(content.length > 300){
		alert("작품 설명은 최대 300자까지 입력 가능합니다.");
		$(this).val(content.substring(0, 300));
		$(this).focus();
	}
});

<%-- first enroll 첨부파일 추가하기 --%>
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

<%-- 다음버튼 클릭 시 다음장 + 스크롤 다운 --%>
const nextStep = (e) => {
	let thisSec = e.parentElement.parentElement.id.substr(11,);
	let nextSec;
	let nextTop;
	switch(thisSec){
	case "first" :
		nextSec = document.querySelector("#ann-enroll-second");
		nextSec.style.display = "inline";
		nextTop = nextSec.offsetTop;
		$('html,body').animate({scrollTop:nextTop}, 300);
		break;
	case "second" : 
		nextSec = document.querySelector("#ann-enroll-third");
		nextSec.style.display = "inline";
		nextTop = nextSec.offsetTop;
		$('html,body').animate({scrollTop:nextTop}, 300);
		break;
	}
};

flexCheckDefault.onchange = () =>{
	let check = $(flexCheckDefault).is(':checked');
	if(check){
		flexCheckDefault.value = "Y";
	}
	else{
		flexCheckDefault.value = "";
	}
}

<%-- 폼제출 --%>
const enrollSubmit = (e) => {
	if(confirm('공고를 등록하시겠습니까?')){
		return true;
	}
	return false;
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
