<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>패스워드 찾기</title>
</head>
<body>
<form name="pwfindscreen" method = "POST" action= "<%= request.getContextPath() %>/member/findPwResult">
	<div id="findPw_head">
      <h2>패스워드 찾기</h2>
    </div><br><br>
			<div class = "search_title">
				<h3>본인확인</h3>
			</div>
		<section class = "form_search">
			<div class = "find_Id">
				<label>아이디</label>
				<input type="text" name="memberId" class = "btn-memberId" placeholder = "등록한 아이디">
			</div>
			<div class = "find_name">
				<label>이름</label>
				<input type="text" name="memberName" class = "btn-name" placeholder = "등록한 이름">
			<br>
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" name="enter" value="찾기" onclick="frmsubmit1()">
		<input type="button" name="cancle" value="취소" onclick= "window.close()">
 	</div>
 </form>
<script>
const frmsubmit1 = () => {
	console.log("폼을 보냅니다.");
	const frm = document.pwfindscreen;
	console.log(frm);
//	frm.target = title;
	frm.submit();
};
</script>
</body>
</html>