<%-- 아이디 중복검사 팝업창 '사용가능한 아이디 입니다.' '이미 사용중인 아이디 입니다.' --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = request.getParameter("memberId");
	boolean available = (boolean) request.getAttribute("available");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/cIdDup.css" />
<meta charset="UTF-8">
<title>ID 중복확인</title>
</head>
<body>
	<div id="checkId-container">
	<% if(available) { %>
		<p>[<%= memberId %>]는 사용가능합니다.</p>
		<p><button type="button" onclick="closePopup();">닫기</button></p>
		<script>
		const closePopup = () => {
			const frm = opener.document.memberEnrollFrm;
			frm.memberId.value = '<%= memberId %>';
			frm.idValid.value = 1;
			
			
			self.close();
		};
		</script>
	<% } else { %>
		<p>[<span id="duplicated"><%= memberId %></span>]는 이미 사용중입니다.</p>
		<form name="checkIdDuplicateFrm" action="<%= request.getContextPath() %>/member/checkIdDuplicate">
			<input type="text" name="memberId" />
			<input type="submit" value="ID 중복검사" />
		</form>
	<% } %>
	</div>
</body>
</html>