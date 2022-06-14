<%-- 로그인 성공여부 팝업창 '로그인 되었습니다.' '로그인에 실패하였습니다.' --%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/mLogin.css" />
<section id=login-container>
	<h2>로그인</h2>
	<form name="memberLoginFrm" method="POST">
		<table>
			<tr>
				<th>ID<sup>*</sup></th>
				<td>
					<input type="text" name="memberId" id="_memberId">
				</td>
			</tr>
			<tr>
				<th>비밀번호<sup>*</sup></th>
				<td>
					<input type="password" name="password" id="_password"><br>
				</td>
			</tr>
		</table>
	</form>
</section>
<script>

// 유효성 검사
document.memberLoginFrm.onsubmit = () => {

};
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>