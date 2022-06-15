<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findPw.css" />
<meta charset="UTF-8">
<title></title>
</head>
<body>
<form name="pwfindscreen" method = "POST">
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
		<input type="button" name="enter" value="찾기" onclick="location.href='<%= request.getContextPath() %>/member/findPwResult';">
		<input type="button" name="cancle" value="취소" onclick= "window.close()">
 	</div>
 </form>

</body>
</html>