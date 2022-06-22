<%@page import="board.model.dto.Report"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
   List<Report> list = (List<Report>) request.getAttribute("list");
   String pagebar = (String) request.getAttribute("pagebar");
   String searchType = request.getParameter("searchType");
   
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/reportlist.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="<%= request.getContextPath() %>/mypage/memberList" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원조회</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">신고내역</a></li>
    </ul>
  </div>
  <div id="myboard">
    <div>
      <div id="myann_head">
        <h2>신고 내역</h2>
        <div id="condition">
          <select name="searchType" id="searchType">
            <option value="default">처리상태</option>
            <option value="undo" <%="undo".equals(searchType) ? "selected" : ""%>>접수</option>
            <option value="ing" <%="ing".equals(searchType) ? "selected" : ""%>>처리중</option>
            <option value="end" <%="end".equals(searchType) ? "selected" : ""%>>처리완료</option>
          </select>
        </div>
      </div>
      <table>
        <thead id="list-head">
             <tr>
               <th>날짜</th>
               <th>게시판</th>
               <th>제목</th>
               <th>처리상태</th>
             </tr>
        </thead>
        <tbody id="list-content">
 	<% if(list != null && !list.isEmpty()){
        String status = "완료";
      int boardNo = 0;
      int actorNo = 0;
      int annNo = 0;
      int commentNo = 0;
      String boardName = "게시판";
      String reportUrl = "";
      
        for(int i = 0; i < list.size(); i++){
           
           reportUrl = request.getContextPath() + "/board/boardView?no=" + list.get(i).getBoardNo();
         boardNo = list.get(i).getBoardNo();
         actorNo = list.get(i).getActor_no();
         annNo = list.get(i).getAnnNo();
         commentNo = list.get(i).getCommentNo();
         
         if(list.get(i).getReportStatus().equals("U")){
            status = "접수";
         } else if(list.get(i).getReportStatus().equals("I")){
            status = "처리중"; 
         }
         
         if(boardNo==0 & actorNo!=0 & annNo==0 & commentNo == 0){
            boardName = "배우 게시판";         
            reportUrl= request.getContextPath() + "/actor/actorView?actorNo=" + list.get(i).getActor_no();
         } else if(boardNo==0 & actorNo==0 & annNo!=0 & commentNo == 0){
            boardName = "공고 게시판";
            reportUrl= request.getContextPath() + "/ann/annView?annNo=" + list.get(i).getAnnNo();
         } else if(boardNo!=0 & actorNo==0 & annNo==0 & commentNo != 0){
            boardName = "댓글";
            reportUrl= request.getContextPath() + "/board/boardView?no=" + list.get(i).getBoardNo();
         }  
   
      %>
          <tr>
            <td><%= list.get(i).getReportDate() %></td>
            <td><%= boardName %></td>
            <td><a href="<%= reportUrl %>"><%= list.get(i).getReportContent() %></a></td>
            <td><%= list.get(i).getReportStatus() %></td>
          </tr>
     <%    } %>
      <% } else { %>
      		<tr>
      			<td>조회된 공고가 없습니다.</td>
      		</tr>
      <% } %>
        </tbody>
      </table>
    </div>
   <div id="pagebar">
      <%= pagebar %>
   </div>
  </div>

  <script>
     searchType.addEventListener('change', (e) => {
      document.querySelector("#list-content").innerHTML = "";
      const {value} = e.target;
      // 공고 마감순 선택 시 페이지 요청
      
      if(value=="undo"){
          location.href=`<%= request.getContextPath() %>/mypage/undoReportList?searchType=\${value}`;
      } else if(value=="ing"){
         location.href=`<%= request.getContextPath() %>/mypage/ingReportList?searchType=\${value}`;   
      } else if(value=="end"){
         location.href=`<%= request.getContextPath() %>/mypage/endReportList?searchType=\${value}`;
      } else {
         location.href=`<%= request.getContextPath() %>/mypage/reportList?searchType=\${value}`;
      }
      
   });
  
  
  
    const mousein = (menu) => {
      now_menu.classList.remove('current');
      menu.classList.add('current');
    };

    const mouseout = (menu) => {
      now_menu.classList.add('current');
      menu.classList.remove('current');
    }
  </script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>