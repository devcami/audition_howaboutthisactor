<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<h2>비밀번호 찾기</h2>
    <br>
	<form name="pwFindFrm" method = "POST" action= "<%= request.getContextPath() %>/member/findPw">
		<div class = "search">
			<h3>본인확인</h3>
			<label>아이디</label>
			<input type="text" name="memberId" id="memberId" class="btn-memberId" placeholder = "아이디를 입력해주세요">
			<br />
			<label>전화번호</label>
			<input type="text" name="phone" id="phone" class="btn-phone" placeholder="핸드폰번호를 입력해주세요">
			<br />
			<input type="submit" name="enter" value="찾기">
			<input type="button" name="cancel" value="취소" onclick= "window.close()">
	 	</div>
 	</form>
<script>
document.pwFindFrm.onsubmit = () => {
 	if (!/^[A-Za-z0-9]+$/.test(memberId.value)) {
		alert("아이디를 입력해주세요");
		return false;
	 }
	if (!/^[0-9]+$/.test(phone.value)) {
		alert("핸드폰 번호를 입력해주세요");
		return false;
	}
};
</script>
</body>
</html>