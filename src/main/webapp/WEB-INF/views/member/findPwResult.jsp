<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="member.model.dto.Member"%>
<%@page import="member.model.service.MemberService" %>
<%@page import="java.util.List"%>	

<%
	String memberId = (String) request.getAttribute("memberId");
	System.out.println("resultjps단 아이디" + memberId);
//	String password = (String) request.getAttribute("password");
//    System.out.println("resultjsp단 패스워드"+ password);

%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/findIdPw.css" />
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
</head>
<body>

  <form name="pwsearch" method="post">
      <div class = "container">
      	<div class = "found-success">
	      <h4> 비밀번호 재설정 </h4>  
			<section class = "new_pw">	
			<div>
				<label>새로운 비밀번호를 입력해주세요.</label>
			</div>
			<div class = "new_password">
				<label>새로운 비밀번호</label>
				<input type="text" name="newPw" class = "btn-ps" placeholder = "새 비빌번호를 입력해 주세요.">
			<br>
			</div>
			<div class = "new_password1">
				<label>새로운 비밀번호 확인</label>
				<input type="text" name="newPw1" class = "btn-ps1" placeholder = "새 비빌번호를 똑같이 다시 입력해 주세요.">
			<br>
			</div>
			<br>
	</section>
	     </div>
	     <div class = "found-pw-login">
 		    <input type="button" id="btnLogin" value="비밀번호 변경" onClick ="pwUpdate()"/>
       	</div>
       	</div>
      </form>
   <script>
  // 비밀번호 규칙에 맞추어 유효성 검사 해야함...
  // 비밀번호 입력안하면 창 띄우자!!...
  const pwUpdate = () => {
	const title = "newPwUpdatePopup";
	const spec = "width=500px, height=350px";
	const popup = open("", title, spec);
	
	alert("비밀번호 변경이 완료되었습니다.")
};
   </script>
   
</body>
</html>