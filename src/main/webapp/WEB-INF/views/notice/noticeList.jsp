<%@page import="java.util.List"%>
<%@page import="notice.model.dto.NoticeExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

   List<NoticeExt> list = (List<NoticeExt>) request.getAttribute("list");

   String pagebar = (String) request.getAttribute("pagebar");
   
   String searchType = request.getParameter("searchType");
   String searchKeyword = request.getParameter("searchKeyword");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/notice.css" />
<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt="게시판로고" />
</div>

 <section id="container">
 <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="<%= request.getContextPath() %>/notice/noticeList" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">공지 사항</a></li>
      <li><a href="<%= request.getContextPath() %>/board/boardList" onmouseover="mousein(this);" onmouseout="mouseout(this)">커뮤니티 게시판</a></li>
    </ul>
 </div>
<div id="myboard">
   <div>
      <div id="boardList_head">
         <h2>공지 사항</h2>
       </div>
   			<table class="table table-hover" id="tbl-board">
        	  <thead id="list-head">
      		   <tr>
          		  <th>번호</th>
          		  <th>제목</th>
           		  <th style="text-align: center;">작성자</th>
            	  <th style="text-align: center;">작성일</th>
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
      for(NoticeExt notice : list){
%>
         	<tr>
           		 <td><%= notice.getNo() %></td>
           		 <td>
             	 <a href="<%= request.getContextPath() %>/notice/noticeView?no=<%= notice.getNo() %>" style="text-decoration-line:none; color:black;">
               		<%= notice.getTitle() %>
              	 </a>
              		 <%-- 댓글개수 표시 --%>
              		 <% if(notice.getCommentCount() > 0){ %>
              	    (<%= notice.getCommentCount() %>)
             		  <% } %>
           		 </td>
           		 <td style="text-align: center;"><%= notice.getMemberId() %></td>
           		 <td style="text-align: center;"><%= notice.getRegDate() %></td>
           		 <td style="text-align: center;"><%= notice.getReadCount() %></td>
        	</tr>
<%    
      }
   } 
%>
      		  </tbody>
   		</table>
   <% if(loginMember != null && (loginMember.getMemberRole() == MemberRole.A)){ %>
	<input 
		type="button" value="글쓰기" id="btn-add" 
		onclick="location.href='<%= request.getContextPath() %>/notice/noticeEnroll';"/>
<% } %>

 </div>
</div>
</section>
	<div id="pagebar">
   		   <%= pagebar %>
   	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>