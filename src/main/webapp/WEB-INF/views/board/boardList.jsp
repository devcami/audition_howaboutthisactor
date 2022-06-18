<%@page import="java.util.List"%>
<%@page import="board.model.dto.BoardExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% 
	List<BoardExt> list = (List<BoardExt>) request.getAttribute("list");

	String pagebar = (String) request.getAttribute("pagebar");
	
	String searchKeyword = request.getParameter("searchKeyword");

%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt="게시판로고" />
</div>

<section id="board-container">
	<div>
		<div class="row">
			<form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="bbsTitle">제목</option>
								<option value="userID">작성자</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
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
					<a href="<%= request.getContextPath() %>/board/boardView?no=<%= board.getNo() %>">
					<%= board.getTitle() %>
					</a>
					<%-- 댓글개수 표시 --%>
					<% if(board.getCommentCount() > 0){ %>
						(<%= board.getCommentCount() %>)
					<% } %>
				</td>
				<td><%= board.getMemberId() %></td>
				<td><%= board.getRegDate() %></td>
				<td>
		<% if(board.getAttachCount() > 0) { %>					
					<img src="<%= request.getContextPath() %>/images/attachfile.png" style="width: 23px" />
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
</section>
	<input 
	type="button" value="글쓰기" id="btn-add"  class="btn"
	onclick="location.href='<%= request.getContextPath() %>/board/boardEnroll';"/>
	
	<div id="pagebar">
		<%= pagebar %>
	</div>
	
<script>

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
