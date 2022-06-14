<%-- 로그인 성공여부 팝업창 '로그인 되었습니다.' '로그인에 실패하였습니다.' --%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/mLogin.css" />
<section id=login-container>
	<form name="memberLoginFrm" method="POST">
	<div id="Login_head">
      <h2>로그인</h2>
    </div><br><br>
		<table>
			<tr>
				<th>
					<input type="text" placeholder="ID" name="memberId" id="_memberId">
				</th>
			</tr>
			<tr>
				<td>
					<input type="password" placeholder="비밀번호" name="password" id="_password"><br>
				</td>
			</tr>
		</table>
		<br>
				<input type="submit" id="button" value="Login" >
		<br><br>
	
	<div id="naver_id_login">
<%--<a href="${url}"></a> 네이버 로그인 페이지 이동 --%>
	<img id="naver" src="${pageContext.request.contextPath}/images/naverLogin.png">
	</div><br>
	<div id="kakao_id_login">
<%--<a href="${url}"></a> 카카오 로그인 페이지 이동 --%>
	<img id="kakao" src="${pageContext.request.contextPath}/images/kakaoLogin.png">
	</div><br>
	
	<div id="enroll">회원가입</div>
	<div id="enroll">아이디 찾기</div>
	
	</form>
</section>
<script>

// 유효성 검사
document.memberLoginFrm.onsubmit = () => {
	
};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>