<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
<form name="idfindscreen" method = "POST" action= "<%= request.getContextPath() %>/member/findIdResult">
	<div id="findId_head">
      <h2>아이디 찾기</h2>
    </div><br>
			<div class = "search_title">
				<h3>휴대폰 본인확인</h3>
			</div>
		<section class = "form_search">
			<div class = "find_name">
				<label>이름</label>
				<input type="text" name="memberName" class = "btn-name" placeholder = "등록한 이름">
			<br>
			</div>
			<div class = "find_phone">
				<label>번호</label>
				<input type="text" name="phone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
				<%--onKeyup = "addHypen(this);"  --%>
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input class="Find" type="button" id="find" name="enter" value="아이디 찾기" onclick="frmsubmit()">
		<input class="Find" type="button" name="cancle" value="취소" onclick= "window.close()">
 	</div>
 </form>
<script>
const frmsubmit = () => {
//	console.log("폼을 보냅니다.");
	const frm = document.idfindscreen;
 	if (frm.memberName.value.length < 1) {
		  alert("이름을 입력해주세요");
		  return;
		 }

	if (!/^010\d{8}$/.test(frm.phone.value)) { // 하이픈 있다면 숫자바뀜
			  alert("유효한 전화번호가 아닙니다. 010으로 시작하는 11자리 번호를 정확하게 적어주세요.");
			  return;
	 }
	
//	console.log(frm);
	frm.submit();
};

/* 자동 하이픈 처리 구현...
function addHypen(obj) {
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}
*/

</script>

</body>
</html>
