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
	
          <div class="col-lg-8">
          <!-- Post title-->
             <h1 class="fw-bolder mb-1">
             <span><%= notice.getTitle() %></span>
             </h1>
  
          <!-- Post meta content-->
             <div class="text-muted fst-italic mb-2">
              Posted on <%= notice.getRegDate() %>&nbsp;
              read count <%= notice.getReadCount() %>
             &nbsp;
             <button class="btn" style="float:right"
				onclick="location.href='<%= request.getContextPath() %>/notice/noticeList'">
			 	 뒤로 가기 </button>
			 	 &nbsp;
   			 </div>
  			</div>

          <hr>
         <!-- Post content-->
           <section class="mb-5">
           	<br />
           	<h2>
           		<span><%= notice.getContent() %></span>
           </h2>
           </section>	
			
			<br />
			<% if(canEdit){ %>
		   <div>
		  <%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
		  		 <input type="button" value="수정하기" onclick="updateNotice()">
		   		 <input type="button" value="삭제하기" onclick="deleteNotice()">
			<% } %>
		   </div>
                   	
	<hr style="margin-top:30px;" />	
 
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
		
		const target = e.target.parentElement.parentElement; // button.btn-reply의 부모tr
		console.log(target);
		target.insertAdjacentElement('afterend', tr);
		
		
		// 이벤트핸들링은 1회만 허용.
		e.target.onclick = null;
		
	};
});


document.querySelector("textarea[name=content]").onfocus = (e) => {
	if(<%= loginMember == null %>)
		loginAlert();
};

const commentSubmitHandler = (e) => {
	if(<%= loginMember == null %>){
		loginAlert();
		return false; 		
	}
	
	const contentVal = e.target.content.value.trim();
	if(!/^(.|\n)+$/.test(contentVal)){
		alert("댓글 내용을 작성해주세요.");
		e.target.content.focus();
		return false;
	}

};

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
});	


const updateNotice = () => {
	location.href = "<%= request.getContextPath() %>/notice/noticeUpdate?no=<%= notice.getNo() %>";
}
<% } %>

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
