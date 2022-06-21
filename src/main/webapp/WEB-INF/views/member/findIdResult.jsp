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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
<% if(memberId != null){ %>
  <form name="idsearch" method="post">
  	<div id="findId_result">
      <h2>아이디 찾기 결과</h2>
    </div><br>
      <div class = "container">
      	<div class = "found-success">
	      <h4>  회원님의 아이디는 </h4>  
     <div class ="found-id"><%= memberId%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "find-after">
 		    <input class="Find" type="button" id="btnLogin" value="창닫기" onClick ="window.close()"/>
 		    <input class="Find" type="button" id="btnLogin" value="비밀번호 찾기" onClick ="findPw1()"/>
       	</div>
      </div>
      </form>
    <% } else { %>
      
   <form name= "id_misssearch" method="post">
         <div class = "container">
      	<div class = "found-success">
	      <h4>  회원정보가 없습니다. </h4>  
	     </div>
	     <div class = "find-after">
 		    <input class="Find" type="button" id="btnLogin" value="다시 입력하기" onClick ="findId1()"/>
 		    <input class="Find" type="button" id="btnLogin" value="창닫기" onClick ="window.close()"/>
       	</div>
      </div>
   
   </form>
   	<% } %>   
      
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

<form name="findIdFrm" action="<%= request.getContextPath() %>/member/findId">
	<input type="hidden" name="memberId" />
</form>
<script>
const findId1 = () => {
	const title = "findIdPopup";
	const spec = "width=500px, height=350px";
	const popup = open("", title, spec);
	
	const frm = document.findIdFrm;
	frm.target = title; // 해당팝업에서 폼을 제출!
	frm.submit();
};

</script>

</body>
</html>