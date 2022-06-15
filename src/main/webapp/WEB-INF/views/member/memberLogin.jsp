<%-- 로그인 성공여부 팝업창 '로그인 되었습니다.' '로그인에 실패하였습니다.' --%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@page import="member.model.dto.MemberRole"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/mLogin.css" />
<%


//	String msg = (String) session.getAttribute("msg");
//	if(msg != null)
//		session.removeAttribute("msg");

String saveId = null; // 아이디저장을 체크한 경우, memberId값이 담길 변수
Cookie[] cookies = request.getCookies();
if(cookies != null){
	for(Cookie cookie : cookies){
		if("saveId".equals(cookie.getName())){
			saveId = cookie.getValue();
		}
	}
}
else {
}
%>

<%-- 유효성 검사 --%>
<script> 
function.btnClick() => {
<% if(msg != null){ %>
	alert("<%= msg %>");
<% } %>
	
	
<% if(loginMember == null) { %>
	document.loginFrm.onsubmit = (e) => {
		const memberIdVal = memberId.value;
		const passwordVal = password.value;
		
		if(!/^.{4,}$/.test(memberIdVal)){
			alert("유효한 아이디를 입력해주세요.");
			memberId.select();
			return false;
		}
		if(!/^.{4,}$/.test(passwordVal)){
			alert("유효한 비밀번호를 입력해주세요.");
			password.select();
			return false;
		}
	};	
<% } %>
};


</script>

<section id=login-container>
	<% if(loginMember == null){ %>
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
			<tr>
				<td colspan="2">
					<input type="checkbox" name="saveId" id="saveId" <%= saveId != null ? "checked" : "" %>/>
					<label for="saveId">아이디저장</label>
				</td>
			</tr>
		</table>
		<br>
				<input type="submit" id="button" value="Login" onClick='btnClick()'>
		<br><br>
	<div id="naver_id_login">
<%--<a href="${url}"></a> 네이버 로그인 페이지 이동 --%>
	<img id="naver" src="${pageContext.request.contextPath}/images/naverLogin.png">
	</div><br>
	<div id="kakao_id_login">
<%--<a href="${url}"></a> 카카오 로그인 페이지 이동 --%>
	<img id="kakao" src="${pageContext.request.contextPath}/images/kakaoLogin.png">
	</div><br>
	
	<%-- span태그 css이용해서 nbsp대신 띄워주자 ㅠㅠ --%>
	<span id="enroll" onclick="location.href='<%= request.getContextPath() %>/member/memberEnroll';">회원가입</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<span>|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<span id="id_find" onclick="location.href='<%= request.getContextPath() %>/member/findId';">ID 찾기</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<span>|</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<span id="ps_find">비밀번호 찾기</span>
				
	<% } else { %>
	<%-- 로그인 성공시 --%>
		<table id="login">
			<tbody>
				<tr>
					<td><%= loginMember.getMemberName() %>님, 안녕하세요.</td><br>
				</tr>
				<tr>
				<td>
					<input type="button" value="로그아웃" onclick="location.href='<%= request.getContextPath() %>/member/logout';"/>							
				</td>
				</tr>
			</tbody>
		</table>
		
	<% } %>
	
	</form>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>