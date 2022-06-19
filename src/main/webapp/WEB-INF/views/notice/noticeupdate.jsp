
<%@page import="java.util.List"%>
<%@page import="notice.model.dto.NoticeExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NoticeExt notice = (NoticeExt) request.getAttribute("notice");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />

<section id="board-container">
<h2>게시판 수정</h2>
<form 
	name="noticeUpdateFrm" 
	action="<%=request.getContextPath() %>/notice/noticeUpdate" 
	method="post"
	enctype="multipart/form-data">
	<input type="hidden" name="no" value="<%= notice.getNo() %>" />
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" value="<%= notice.getTitle() %>" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="memberId" value="<%= notice.getMemberId() %>" readonly/>
		</td>
	</tr>
 	<tr>
		<th>내 용</th>
		<td>
			<textarea rows="5" cols="40" name="content"><%= notice.getContent() %></textarea>
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기"/>
			<input type="button" value="취소" onclick="history.go(-1);"/>
		</th>
	</tr>
</table>
</form>
</section>
<script>

document.noticeUpdateFrm.onsubmit = (e) => {
	const frm = e.target;
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	const titleVal = frm.title.value.trim(); // 좌우공백
	if(!/^.+$/.test(titleVal)){
		alert("제목을 작성해주세요.");
		frm.title.select();
		return false;
	}		
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	const contentVal = frm.notice.value.trim();
	if(!/^(.|\n)+$/.test(contentVal)){
		alert("내용을 작성해주세요.");
		frm.content.select();
		return false;
	}
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
