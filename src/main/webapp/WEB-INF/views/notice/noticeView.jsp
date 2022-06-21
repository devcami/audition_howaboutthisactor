<%@page import="java.util.List"%>
<%@page import="notice.model.dto.NoticeExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	NoticeExt notice = (NoticeExt) request.getAttribute("notice");

   String pagebar = (String) request.getAttribute("pagebar");
   
   boolean canEdit = loginMember != null 
			&& (loginMember.getMemberRole() == MemberRole.A);
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
          <div class="col-lg-8">
          <!-- Post title-->
             <h1 class="fw-bolder mb-1">
             <span><%= notice.getTitle() %></span>
             </h1>
			 <% if (canEdit) { %>
             <div class="text-muted fst-italic mb-2">
              Posted on <%= notice.getRegDate() %>&nbsp;
              read count <%= notice.getReadCount() %>
             &nbsp;
	  		 <input type="button" class="btn-up"  value="수정하기" onclick="updateNotice()">
	   		 <input type="button" class="btn-de"  value="삭제하기" onclick="deleteNotice()">
             <button class="btn" style="float:right"
				onclick="location.href='<%= request.getContextPath() %>/notice/noticeList'">
			 	 뒤로 가기 </button>
			 	 &nbsp;
   			 </div>
   			 <% } %> 
  		</div>

          <hr>
        
           <section class="mb-5">
           	<br />
           	<h2>
           		<span><%= notice.getContent() %></span>
           </h2>
           </section>	
			<br />          	
	<hr />	
 </div>
</div> <!-- myboard 끝 -->
</section>
<script>
/**
 * .btn-reply click eventhandler binding 
 */
document.querySelectorAll(".btn-delete").forEach((button) => {
	button.onclick = (e) => {
		if(!confirm("정말 삭제하시겠습니까?")) return;
		document.noticeCommentDelFrm.no.value = e.target.value;
		document.noticeommentDelFrm.submit();
	}
});
		

document.noticeCommentFrm.onsubmit = commentSubmitHandler;

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
	document.querySelector("#memberId").focus();
};

</script>

<% if(canEdit){ %>
<form action="<%= request.getContextPath() %>/notice/noticeDelete" name="noticeDeleteFrm" method="POST">
	<input type="hidden" name="no" value="<%= notice.getNo() %>" />
</form>
<script>
/**
 * POST /board/boardDelete
 * - no전송
 * - 저장된 파일 삭제 : java.io.File 
 */
const deleteNotice = () => {
	if(confirm("정말 이 공지를 삭제하시겠습니까?"))
		document.noticeDeleteFrm.submit();
}
const updateNotice = () => {
	location.href = "<%= request.getContextPath() %>/notice/noticeUpdate?no=<%= notice.getNo() %>";
}
<% } %>
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
