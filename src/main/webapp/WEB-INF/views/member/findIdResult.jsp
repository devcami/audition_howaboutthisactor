<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.model.dto.Member"%>
<%@page import="member.model.service.MemberService" %>
<%@page import="java.util.List"%>

<%
	String memberId = (String) request.getAttribute("Id");
     System.out.println("resultjsp단 아이디"+ memberId);

%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>

  <form name="idsearch" method="post">
      <div class = "container">
      	<div class = "found-success">
	      <h4>  회원님의 아이디는 </h4>  
     <div class ="found-id"><%= memberId%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "find-after">
 		    <input type="button" id="btnLogin" value="창닫기" onClick ="window.close()"/>
 		    <input type="button" id="btnLogin" value="비밀번호 찾기" onClick ="findPw1()"/>
       	</div>
      </div>
      </form>
<form name="findPwFrm" action="<%= request.getContextPath() %>/member/findPw">
	<input type="hidden" name="password" />
</form>
<Script>
const findPw1 = () => {
	window.close();
	const title = "findPwPopup";
	const spec = "width=500px, height=350px";
	const popup = open("", title, spec);
	
	const frm = document.findPwFrm;
	frm.target = title; // 해당팝업에서 폼을 제출!
	frm.submit();
};
</Script>
</body>
</html>