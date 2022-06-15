<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.Date"%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@page import="member.model.dao.MemberDao" %>
<%@page import="member.controller.FindIdServlet" %>
<%@page import="member.controller.FindIdResultServlet" %>
<%@page import="ann.model.dto.Ann"%>	

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/fResult.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <form name="pwsearch" method="post">
      <div class = "container">
      	<div class = "found-success">
	      <h4>  회원님의 비밀번호는 </h4>  
	      <div class ="found-pw"> 
	       <%-- <%=pw.value> --%>  
	         </div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-pw-login">
 		    <input type="button" id="btnLogin" value="로그인하기" onClick ="window.close()"/>
       	</div>
       	</div>
      </form>
   
</body>
</html>