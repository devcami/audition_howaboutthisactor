<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="member.model.dto.Member"%>
<%@page import="member.model.service.MemberService" %>
<%@page import="java.util.List"%>	

<%
	Member member = (Member) request.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
</head>
<body>
	<div id="newPw_head">
	<h2> 비밀번호 재설정 </h2>
	</div>
	<br><br><br><br>
		<div class="newPw">
			<input type="hidden" name="memberId" id="memberId" value="<%= member.getMemberId() %>" />
			<label>새 비밀번호</label>
			<input type="password" name="newPw" id="newPw" class="btn-ps" placeholder = "새 비밀번호를 입력해 주세요.">
		</div>
		<div class="newPwCheck">
			<label>새 비밀번호 확인</label>
			<input type="password" name="newPwCheck" id="newPwCheck" class="btn-ps" placeholder = "새 비밀번호를 다시 입력해 주세요.">
		</div>
		<br>
		<input class="Find" type="button" id="btnPwChange" value="비밀번호 변경" onclick="clickEvent();"/>
		<input class="Find" type="button" name="cancel" value="취소" onclick= "window.close()">
<script>
newPwCheck.onblur = () => {
	if(newPwCheck.value !== newPw.value){
		alert("비밀번호가 일치하지 않습니다.");
		newPwCheck.select();
		return false;
	}
	return true;
};
const clickEvent = () => {
	if(!/^[A-Za-z0-9!@#$%^&*()]{6,}$/.test(newPw.value)){
		alert("비밀번호는 영문자/숫자/특수문자!@#$%^&*()로 6글자 이상이어야 합니다.");
		return false;
	}
	if(!newPwCheck.onblur()){
		return false;		
	}
	
	$.ajax({
		url : "<%= request.getContextPath() %>/member/findPwResult",
		type : "POST",
		data : {
			memberId : memberId.value,
			newPw : newPw.value
		},
		success(resp){
			console.log(resp);	
			if(resp > 0){
				alert('비밀번호가 성공적으로 변경되었습니다.');
				opener.parent.location.reload();
				window.close();
			}
		},
		error : console.log
	});
};
</script>
   
</body>
</html>