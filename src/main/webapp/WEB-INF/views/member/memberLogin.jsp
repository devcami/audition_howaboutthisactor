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
	<div id="login-header">
   		<span>로그인</span>
    </div>
	<form name="memberLoginFrm" method="POST" id="member-login-form">
		<table class="table table-borderless">
			<tr>
				<th>
					아이디
				</th>
				<td>
					<input type="text" placeholder="아이디를 입력해주세요." name="memberId" id="_memberId">
				</td>
			</tr>
			<tr>
				<th>
					비밀번호
				</th>
				<td>
					<input type="password" placeholder="비밀번호를 입력해주세요." name="password" id="_password"><br>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" name="saveId" class="saveId" id="saveId" <%= saveId != null ? "checked" : "" %>/>
					<label for="saveId" class="saveId">아이디저장</label>
					<input type="submit" id="btn-login" class="btn btn-primary" value="Login" onClick='btnClick()'>
				</td>
			</tr>
		</table>
	<div id="SNSLogin">
		<%--<a href="${url}"></a> 네이버 로그인 페이지 이동 --%>
		<img id="naver" src="${pageContext.request.contextPath}/images/naverLogin.png">
		<%--<a href="${url}"></a> 카카오 로그인 페이지 이동 --%>
		<img id="kakao" src="${pageContext.request.contextPath}/images/kakaoLogin.png">
	</div>
	
	<div id="btn-group" class="btn-group" role="group" aria-label="Basic example">
	  <button type="button" class="btn f-btn b-line" onclick="location.href='<%= request.getContextPath() %>/member/memberEnroll';">회원가입</button>
	  <button type="button" class="btn f-btn b-line" id="id_find" onclick="findId();">아이디 찾기</button>
	  <button type="button" class="btn f-btn" id="pwd_find" onclick="findPw();">비밀번호 찾기</button>
	</div>
				
	<% } else { %>
		<%-- 로그인 성공시 --%>
<%-- 		<script type="text/javascript">
		// 뒤로 갈 히스토리가 있는 경우 및 우리 시스템에서 링크를 통해 유입된 경우
		if (document.referrer && document.referrer.indexOf("<%= request.getContextPath() %>") !== -1) {
		    history.back();    // 뒤로가기
		}
		// 히스토리가 없는 경우 (URL을 직접 입력하여 유입된 경우)
		else {
		    location.href = "<%= request.getContextPath() %>/";    // 메인페이지로 
		}
		</script> --%>
 		<table id="loginSuccess">
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


<form name="findIdFrm" action="<%= request.getContextPath() %>/member/findId">
	<input type="hidden" name="memberId" />
</form>
<script>
const findId = () => {
	const title = "findIdPopup";
	const spec = "width=300px, height=350px";
	const popup = open("", title, spec);
	
	const frm = document.findIdFrm;
	frm.target = title; // 해당팝업에서 폼을 제출!
	frm.submit();
};
</script>	

<form name="findPwFrm" action="<%= request.getContextPath() %>/member/findPw">
	<input type="hidden" name="password" />
</form>
<script>
const findPw = () => {
	const title = "findPwPopup";
	const spec = "width=300px, height=350px";
	const popup = open("", title, spec);
	
	const frm = document.findPwFrm;
	frm.target = title; // 해당팝업에서 폼을 제출!
	frm.submit();
};
</script>	

<%@ include file="/WEB-INF/views/common/footer.jsp" %>