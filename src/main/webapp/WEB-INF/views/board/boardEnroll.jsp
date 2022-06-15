<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>   
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />

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


</script>
<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt="게시판로고" />
</div>

<section id="board-container">
<div id="board-E">
<form name="boardEnrollFrm"
	  action="<%=request.getContextPath() %>/board/boardEnroll" 
	  method="post"	enctype="multipart/form-data">
	  
  <div class="mb-3 row">
    <label for="title" class="col-sm-2 col-form-label">제  목</label>
    <div class="col-sm-10">
      <input type="text" readonly class="form-control" name="title" id="enroll-title" required>
    </div>
  </div>
  
  <div class="row">
  <div class="col">
  	<label for="memberId" class="col-sm-2 col-form-label">작성자</label>
    <input type="text" class="form-control" name="memberId" class="form-control" value="<%= loginMember.getMemberId() %>" readonly/>
  </div>
  <div class="col">
  <label for="memberId" class="col-sm-2 col-form-label">첨부파일
    <input type="text" class="form-control" placeholder="Last name" aria-label="Last name"></label>
  </div>
</div>

  <div class="mb-3 row">
    <label for="memberId" class="col-sm-2 col-form-label">작성자</label>
    <div class="col-sm-10">
      <input input type="text" name="memberId" class="form-control" value="<%= loginMember.getMemberId() %>" readonly/>
    </div>
  </div>
  
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" id="enroll-title" required></td>
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
		<td><textarea rows="25" cols="40" name="content"></textarea></td>
	</tr>
</table>
</form>
</div>
</section>

<div>
<input type="submit" value="등록하기" id="btn-submit" class="btn" />
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
