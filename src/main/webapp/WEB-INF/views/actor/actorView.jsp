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
  ActorInfoExt actorInfo = (ActorInfoExt) request.getAttribute("actorInfo");
 
 %>
<script> let a; </script>
		<% if(list != null && !list.isEmpty()){
			long miliseconds = System.currentTimeMillis();
			Date today = new Date(miliseconds); 
			for(int i = 0; i < list.size(); i++){ 
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<body>
 <h2> 배우 상세 프로필</h2>
	
		<table>
		
			<tr>
				<td>멤버아이디</td>
				<td><input type="text" name="name"><%= list.get(i).getmemberId() %></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"<%= list.get(i).getactorName() %>></td>
			</tr>
			<tr>
				<td>배우 번호</td>
				<td><input type="text" name="name"<%= list.get(i).getactorNo() %>></td>
			</tr>
			<tr>
				<td>생일 </td>
				<td><input type="text" name="name"<%= list.get(i).getbirth() %>></td>
			</tr>
			<tr>
				<td>나이 </td>
				<td><input type="text" name="name"<%= list.get(i).getage() %>></td>
			</tr>
			<tr>
				<td>학력 </td>
				<td><input type="text" name="name"<%= list.get(i).geteducation() %>></td>
			</tr>
			<tr>
				<td>소속사</td>
				<td><input type="text" name="name"<%= list.get(i).getcompany() %>></td>
			</tr>
			<tr>
				<td>키</td>
				<td><input type="text" name="name"<%= list.get(i).getheight() %>></td>
			</tr>
			<tr>
				<td>몸무게</td>
				<td><input type="text" name="name"<%= list.get(i).getweight() %>></td>
			</tr>
			<tr>
				<td>소속사</td>
				<td><input type="image" name="name"<%= list.get(i).getcompany() %>></td>
			</tr>
			<tr>
				<td>핸드폰 번호</td>
				<td><input type="text" name="name"<%= list.get(i).getphone() %>></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="name"<%= list.get(i).getemail() %>></td>
			</tr>
			<tr>
				<td>취미</td>
				<td><input type="text" name="name"<%= list.get(i).getmemverId() %>></td>
			</tr>
			<tr>
				<td>SNS</td>
				<td><input type="text" name="name"<%= list.get(i).getsns()%>></td>
			
			
			<tr>
				<td>프로필</td>
				<td><<img class="actor_photo" src="<%= request.getContextPath() %>/upload/portfolio/<%= list.get(i).getAttachment().getRenamedFilename()%>">></td>
			</tr>
			
			
		</table>
	
</body>

</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
