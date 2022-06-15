<%@page import="java.util.List"%>
<%@page import="board.model.dto.BoardExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% 
	List<BoardExt> list = (List<BoardExt>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt=게시판로고" />
</div>
<div id="board-t">
<section id="board-container">
<table class="table table-hover" id="tbl-board">
  <thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>첨부파일</th><%--첨부파일이 있는 경우 /images/file.png 표시 width:16px --%>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		
<%
	if(list == null || list.isEmpty()){
%>
		<tr>
			<td colspan="6"> 조회된 정보가 없습니다.</td>
		</tr>
<%
	} else {
		for(BoardExt board : list){
%>
			<tr>
				<td><%= board.getNo() %></td>
				<td>
					<a href="<%= request.getContextPath() %>/board/boardView?no=<%= board.getNo() %>"><%= board.getTitle() %></a>
					<%-- 댓글개수 표시 --%>
					<% if(board.getCommentCount() > 0){ %>
						(<%= board.getCommentCount() %>)
					<% } %>
				</td>
				<td><%= board.getMemberId() %></td>
				<td><%= board.getRegDate() %></td>
				<td>
		<% if(board.getAttachCount() > 0) { %>					
					<img src="<%= request.getContextPath() %>/images/file.png" alt="" />
		<% } %>					
				</td>
				<td><%= board.getReadCount() %></td>
			</tr>
<% 	
		}
	} 
%>
		</tbody>
	</table>
	</div>
	<input 
	type="button" value="글쓰기" id="btn-add" class="btn"
	onclick="location.href='<%= request.getContextPath() %>/board/boardEnroll';"/>

	<div id="pagebar">
		<%= pagebar %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
