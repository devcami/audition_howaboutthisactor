<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findId.css" />
<meta charset="UTF-8">
<title></title>
</head>
<body>
<form name="idfindscreen" method = "POST">
	<div id="findId_head">
      <h2>아이디 찾기</h2>
    </div><br><br>
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
				<input type="text" onKeyup = "addHypen(this);" name="phone" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			<br>
	</section>
	<div class ="btnSearch">
		<input type="button" name="enter" value="찾기">
		<%--  onclick="location.href='<%= request.getContextPath() %>/member/findIdResult'; 아이디 찾는 창으로 이동 --%> 
		<input type="button" name="cancle" value="취소">
 	</div>
 </form>


</body>
</html>