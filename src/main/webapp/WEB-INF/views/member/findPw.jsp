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
<title>비밀번호 찾기</title>
</head>
<body>
	<form name="pwFindFrm" method = "POST" action= "<%= request.getContextPath() %>/member/findPw">
	<div id="findPw_head">
	<h2>비밀번호 찾기</h2>
    </div><br>
		<div class = "search">
			<h3>본인확인</h3>
			</div>
			<div class="find_id">
				<label>아이디</label>
				<input type="text" name="memberId" id="memberId" class="btn-memberId" placeholder = "아이디를 입력해주세요">
				<br>
			</div>
			<div class="find_phone">
				<label>전화번호</label>
				<input type="text" name="phone" id="phone" class="btn-phone" placeholder="핸드폰번호를 입력해주세요">
				<br><br>
			</div>
		<div class="btn">
			<input class="Find" type="submit" name="enter" value="비밀번호 찾기">
			<input class="Find" type="button" name="cancel" value="취소" onclick= "window.close()">
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