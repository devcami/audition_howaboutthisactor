<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="member.model.dto.Member"%>
<%@page import="member.model.service.MemberService" %>
<%@page import="java.util.List"%>	

<%
	String password = (String) request.getAttribute("password");
    System.out.println("resultjsp단 패스워드"+ password);

%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <form name="pwsearch" method="post">
      <div class = "container">
      	<div class = "found-success">
	      <h4>  회원님의 비밀번호는 </h4>  
	      <div class ="found-pw"> 
     <div class ="found-pw"><%= password%></div>
	         </div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-pw-login">
 		    <input type="button" id="btnLogin" value="창닫기" onClick ="window.close()"/>
       	</div>
       	</div>
      </form>
   
</body>
</html>