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
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="창닫기" onClick ="window.close()"/>
       	</div>
      </div>
      </form>
   
</body>
</html>