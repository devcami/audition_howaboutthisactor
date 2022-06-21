<%@page import="java.util.List"%>
<%@page import="board.model.dto.BoardExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% 
   List<BoardExt> list = (List<BoardExt>) request.getAttribute("list");
   String pagebar = (String) request.getAttribute("pagebar");
   
   String searchType = request.getParameter("searchType");
   String searchKeyword = request.getParameter("searchKeyword");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt="게시판로고" />
</div>

<section id="container">
	 <div id="Pmypage-submenu" class="submenu">
    	<ul>
      	<li><a href="<%= request.getContextPath() %>/notice/noticeList" onmouseover="mousein(this);" onmouseout="mouseout(this)">공지 사항</a></li>
      	<li><a href="<%= request.getContextPath() %>/board/boardList" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">커뮤니티 게시판</a></li>
    	</ul>
 	</div>

	<div id="myboard">
	<div>
		<div id="boardList_head">
			<h2>커뮤니티</h2>
			<div id="condition">
				<select name="searchType" id="searchType">
					<option value="boardListAll" <%= (searchType == null) ? "selected" : "" %>>전체</option>
					<option value="title" <%="title".equals(searchType)?"selected":""%>>제목</option>
					<option value="content" <%="content".equals(searchType)?"selected":""%>>글 내용</option>
					<option value="member_id" <%="memberId".equals(searchType)?"selected":""%>>작성자</option>
				</select>
				<div id="search-boardListAll">
	          		<form name="ViewAllBoardFrm" action="<%=request.getContextPath()%>/board/boardList"></form>
          		</div>
				<div id="search-title" class="search-type">
					<form action="<%=request.getContextPath()%>/board/boardFinder?searchType=<%= searchType%>&?searchKeyword=<%= searchKeyword %>">
						<input type="hidden" name="searchType" value="title">
						<input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 글 제목을 검색하세요" value="<%="title".equals(searchType) ? searchKeyword : "" %>">
						<button type="submit" class="btn">검색</button>
					</form>
               </div>
               <div id="search-content" class="search-type">
	         		<form action="<%=request.getContextPath()%>/board/boardFinder?searchType=<%= searchType%>&?searchKeyword=<%= searchKeyword %>">
	                	<input type="hidden" name="searchType" value="content">
						<input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 내용을 입력하세요." value="<%= "content".equals(searchType) ? searchKeyword : "" %>">
						<button type="submit" class="btn">검색</button>
	              	</form>
               </div>
               <div id="search-memberId" class="search-type">
					<form action="<%=request.getContextPath()%>/board/boardFinder?searchType=<%= searchType%>&?searchKeyword=<%= searchKeyword %>">
						<input type="hidden" name="searchType" value="member_id">
						<input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 작성자를 입력하세요." value="<%= "memberId".equals(searchType) ? searchKeyword : "" %>">
						<button type="submit" class="btn">검색</button>
                   </form>
               </div>
			</div>
		</div>   
		
   		<table class="table table-hover" id="tbl-board">
         	 <thead id="list-head">
        	 <tr>
           		 <th>번호</th>
           		 <th>제목</th>
           		 <th style="text-align: center;">작성자</th>
           		 <th style="text-align: center;">작성일</th>
           		 <th style="text-align: center;">첨부파일</th><%--첨부파일이 있는 경우 /images/file.png 표시 width:16px --%>
           		 <th style="text-align: center;">조회수</th>
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
              	 <a href="<%= request.getContextPath() %>/board/boardView?no=<%= board.getNo() %>" style="text-decoration-line:none; color:black;">
               <%= board.getTitle() %>
              	 </a>
               <%-- 댓글개수 표시 --%>
               <% if(board.getCommentCount() > 0){ %>
                  (<%= board.getCommentCount() %>)
               <% } %>
            	</td>
            	<td style="text-align: center;"><%= board.getMemberId() %></td>
           		<td style="text-align: center;"><%= board.getRegDate() %></td>
           		<td style="text-align: center;">
      			<% if(board.getAttachCount() > 0) { %>               
               <img src="<%= request.getContextPath() %>/images/attachfile.png" style="width: 23px" />
      			<% } %>               
            	</td>
           	 	<td style="text-align: center;"><%= board.getReadCount() %></td>
         	</tr>
			<%    
    			 } 	
   			}
			%>
      		</tbody>
   		</table>
	</div>
		<div>
			<% if(loginMember != null && (loginMember.getMemberRole() != MemberRole.A)){ %>	
			<input type="button" value="글쓰기" id="btn-add" class="btn" style="float:right"
			   onclick="location.href='<%= request.getContextPath() %>/board/boardEnroll';"/>
			<% } %>
		</div>
		<div id="pagebar">
			<%= pagebar %>
		</div>	
	</div>
</section>
<script>
const mousein = (menu) => {
  now_menu.classList.remove('current');
  menu.classList.add('current');
};

const mouseout = (menu) => {
  now_menu.classList.add('current');
  menu.classList.remove('current');
}
window.onload = () => {
	document.querySelectorAll('.search-type').forEach((div) => {
		div.style.display = "none";
	});
		   
	if("<%= searchKeyword %>" != null){
		const value = $("#searchType option:selected").val();
		console.log(value);
		switch(value) {
		  case "title": 
		     id = "search-title"; 
		     $('#searchType').css("margin-bottom", '0');
		     break;
		  case "content": 
		     id = "search-content"; 
		     $('#searchType').css("margin-bottom", '0');
		     break;
		  case "member_id": 
		     id = "search-memberId"; 
		     $('#searchType').css("margin-bottom", '0');
		     break;
		  case "boardListAll" : 
		     id = "search-boardListAll"; 
		     break;
		}
		document.querySelector(`#\${id}`).style.display = "inline-block";
   } else {
	   
   }
}

searchType.addEventListener('change', (e) => {
   const {value} = e.target;

   document.querySelectorAll('.search-type').forEach((div) => {
     div.style.display = "none";
   });
   
   let id = "";
   if(value == "boardListAll") {
      $('#searchType').css("margin-bottom", '15px');
      document.ViewAllBoardFrm.submit();
   }

   switch(value) {
     case "title": id = "search-title"; break;
     case "content": id = "search-content"; break;
     case "member_id": id = "search-memberId"; break;
   }
   $('#searchType').css("margin-bottom", '0');
   document.querySelector(`#\${id}`).style.display = "inline-block";
 });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>