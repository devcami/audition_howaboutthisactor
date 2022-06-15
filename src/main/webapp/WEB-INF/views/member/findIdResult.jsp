<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.Date"%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@page import="member.model.dao.MemberDao" %>
<%@page import="ann.model.dto.Ann"%>	
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% 
 request.setCharacterEncoding("UTF-8");
    String memberName = request.getParameter("memberName");
     String phone = request.getParameter("phone");
     
 	MemberDao dao = new MemberDao();
 	String member_mid = dao.findId(memberName, phone); //아이디를 디비에서 가져옴..실패시 널
 
 %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/fResult.css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

  <form name="idsearch" method="post">
      <%
       if ( member_mid != null) {
      %>
      
      <div class = "container">
      	<div class = "found-success">
	      <h4>  회원님의 아이디는 </h4>  
	      <div class ="found-id"><%=member_mid%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onClick = 'login()'/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      <h4>  등록된 정보가 없습니다 </h4>  
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnback" value="다시 찾기">
 		    <input type="button" id="btnjoin" value="회원가입">
       	</div>
       </div>
       
    <div class = "adcontainer">
	<a href="#" ><img src = "" /></a>                
</div>   
       <%
  }
 %> 
      </form>
   
</body>
</html>