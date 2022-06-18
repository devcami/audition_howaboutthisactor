<%-- 이메일 중복검사 팝업창 '사용가능한 이메일 입니다.' '이미 사용중인 이메일 입니다.' --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");
	boolean available = (boolean) request.getAttribute("available");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/cEmailDup.css" />
<meta charset="UTF-8">
<title>Email 중복확인</title>
</head>
<body>
	<div id="checkEmail-container">
	<% if(available) { %>
		<p>[<%= email %>]는 사용가능합니다.</p>
		<p><button type="button" onclick="closePopup();">닫기</button></p>
		<script>
		const closePopup = () => {
			const frm = opener.document.memberEnrollFrm;
			frm.email.value = '<%= email %>';
			frm.emailValid.value = 1;
			
			self.close();
		};
		</script>
	<% } else { %>
		<p>[<span id="duplicated"><%= email %></span>]는 이미 사용중입니다.</p>
		<form name="checkEmailDuplicateFrm" action="<%= request.getContextPath() %>/member/checkEmailDuplicate">
			<input type="text" name="email" />
			<input type="submit" value="Email 중복검사" />
		</form>
	<% } %>
	</div>
</body>
</html>