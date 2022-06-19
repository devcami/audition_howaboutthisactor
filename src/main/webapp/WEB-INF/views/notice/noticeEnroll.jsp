<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>   
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />

<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt="게시판로고" />
</div>

<section id="board-container">
<div id="board-E">
<form
	name="noticeEnrollFrm"
	action="<%=request.getContextPath() %>/notice/noticeEnroll" 
	method="post">
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="memberId" value="<%= loginMember.getMemberId() %>" readonly/>
			 
		</td>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="40" name="content"></textarea></td>
	</tr>
</table>
<input type="submit" id="btn-submit" class="btn" type="button" value="등록하기">

</form>
</div>
</section>




<script>
/**
* boardEnrollFrm 유효성 검사
*/

window.onload = () => {	
	document.noticeEnrollFrm.onsubmit = (e) => {
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
}

<%-- 폼제출 
const enrollSubmit(this) = (e) => {
	if(confirm('공지를 등록하시겠습니까?')){
		document.noticeEnrollFrm.submit();
	}
};
--%>


</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
