<%@page import="board.model.dto.Attachment"%>
<%@page import="java.util.List"%>
<%@page import="board.model.dto.BoardExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	BoardExt board = (BoardExt) request.getAttribute("board");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/boardUpdate.css" />
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
 	<div id="myboard2">
		<div>	
			<h2>게시판 수정</h2>
			<form 
				name="boardUpdateFrm" 
				action="<%=request.getContextPath() %>/board/boardUpdate" 
				method="post" enctype="multipart/form-data">
					<input type="hidden" name="no" value="<%= board.getNo() %>" />
					<table id="tbl-board-view">
						<tr>
							<th>제 목</th>
							<td>
							<input type="text" name="title" value="<%= board.getTitle() %>" required>
							</td>
						</tr>
						<tr>
							<th>작성자</th>
								<td>
									<input type="text" name="memberId" value="<%= board.getMemberId() %>" readonly/>
								</td>
						</tr>
	
						<tr>
							<th>첨부파일</th>
							<td >
								<% List<Attachment> attachments = board.getAttachments();
								if(attachments != null && !attachments.isEmpty()){
								for(int i = 0; i < attachments.size(); i++){
								Attachment attach = attachments.get(i); %>
								<img src="<%= request.getContextPath() %>/images/file.png" width="16px">
								<%= attach.getOriginalFilename()%>
								<input type="checkbox" name="delFile" id="delFile<%= i + 1 %>" value="<%= attach.getNo() %>"/>
								<label for="delFile<%= i + 1 %>">삭제</label>
								<br />
								<% 	}
									} %>
								<input type="file" name="upFile1" value="">
								<input type="file" name="upFile2" value="">
							</td>
						</tr>
						<tr>
							<th>내 용</th>
							<td>
								<textarea onkeyup="adjustHeight();" id="content" name="content"><%= board.getContent() %></textarea>
							</td>
						</tr>
						<tr>
							<th class="right" colspan="2">
								<input class="nic" type="submit" value="수정하기"/>
								<input class="nic" type="button" value="취소" onclick="history.go(-1);"/>
							</th>
						</tr>
					</table>
				</form>
			</div>
		</div>
</section>
<script>
/**
 * 업로드 가능한 첨부파일 수 제한하기
 */
const len = document.querySelectorAll("[name=delFile]").length
for(let i = 0; i < len; i++)
	document.querySelectorAll("input[type=file]")[i].style.display = "none";
	
/**
 * [name=delFile] 체크/체크해제시 input[type=file] 노출/감춤처리
 */
document.querySelectorAll("[name=delFile]").forEach((delFile) => {
	delFile.onchange = (e) => {
		const {id, checked} = e.target;
		// console.log(id, checked);
		const n = id.replaceAll(/[^0-9]/g, "");
		const file = document.querySelector(`[name=upFile\${n}]`);
		file.style.display = checked ? "inline" : "none"; // 노출/감춤 처리
		checked || (file.value = ""); // 지정한 파일을 제거 
	};
});


document.boardUpdateFrm.onsubmit = (e) => {
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

//textarea 세로 자동 조절
function adjustHeight() {
	  var textEle = $('textarea');
	  textEle[0].style.height = 'auto';
	  var textEleHeight = textEle.prop('scrollHeight');
	  textEle.css('height', textEleHeight);
	};

	adjustHeight(); // 함수를 실행하면 자동으로 textarea의 높이 조절
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
