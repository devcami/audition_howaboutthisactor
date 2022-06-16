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
	name="boardEnrollFrm"
	action="<%=request.getContextPath() %>/board/boardEnroll" 
	method="post"
	enctype="multipart/form-data">
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
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>			
			<input type="file" name="upFile1">
			<br>
			<input type="file" name="upFile2">
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="40" name="content"></textarea></td>
	</tr>
</table>
</form>
</div>
</section>

<div>
<button id="btn-submit" class="btn" type="button" onclick="enrollSubmit(this);">등록하기</button>
</div>


<script>
/**
* boardEnrollFrm 유효성 검사
*/

window.onload = () => {	
	document.boardEnrollFrm.onsubmit = (e) => {
		const frm = e.target;
		//제목을 작성하지 않은 경우 폼제출할 수 없음.
		const titleVal = frm.title.value.trim(); // 좌우공백
		if(!/^.+$/.test(titleVal)){
			alert("제목을 작성해주세요.");
			frm.title.select();
			return false;
		}		
						   
		//내용을 작성하지 않은 경우 폼제출할 수 없음.
		const contentVal = frm.content.value.trim();
		if(!/^(.|\n)+$/.test(contentVal)){
			alert("내용을 작성해주세요.");
			frm.content.select();
			return false;
		}
	}
}

<%-- 폼제출 --%>
const enrollSubmit = (e) => {
	if(confirm('공고를 등록하시겠습니까?')){
		document.boardEnrollFrm.submit();
	}
};

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
