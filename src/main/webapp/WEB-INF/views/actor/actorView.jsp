<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 

<%
  List<ActorInfo> list = (List<ActorInfo>) request.getAttribute("list");


 %>


<body>
	<form method="POST" action="actorView.jsp">
		<table>
			<tr>
				<td>멤버아이디</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>배우번호</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>학교</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>배우키 </td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>소속사</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>취미</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>SNS</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type="image" name="name"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			
			<tr>
				<td>설명</td>
				<td><textarea rows="8" cols="40" name="description"></textarea></td>
			</tr>
			<tr>
				<td><input type="submit" value="전송"><input type="reset" value="취소"></td>
			</tr>
		</table>
	</form>
</body>


</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
