<%@page import="board.model.dto.BoardComment"%>
<%@page import="board.model.dto.Attachment"%>
<%@page import="java.util.List"%>
<%@page import="board.model.dto.BoardExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	BoardExt board = (BoardExt) request.getAttribute("board");
	
	List<BoardComment> comments = board.getBoardComments();
	
	boolean canEdit = loginMember != null 
			&& (loginMember.getMemberId().equals(board.getMemberId()) 
					|| loginMember.getMemberRole() == MemberRole.A);
	
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<div class="top-logo">
 <img src="<%= request.getContextPath() %>/images/community.jpg" alt="게시판로고" />
</div>

<section id="board-container">
	<table id="tbl-board-view">
		<tr>
			<th>작성자</th>
			<td><%= board.getMemberId() %></td>
		</tr>
		<tr>
			<th>제 목</th> 
			<td><%= board.getTitle() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= board.getReadCount() %></td>
		</tr>
		<% 
			List<Attachment> attachments = board.getAttachments();
			if(attachments != null && !attachments.isEmpty()){
				for(Attachment attach : attachments){
		%>
		<tr>
			<th>첨부파일</th>
			<td>
				<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
				<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px>
				<a href="<%= request.getContextPath() %>/board/fileDownload?no=<%= attach.getNo() %>"><%= attach.getOriginalFilename() %></a>
			</td>
		</tr>
		<%
				}
			}
		%>
		<tr>
			<th>내 용</th>
			<td id="view-content"><%= board.getContent() %></td>
		</tr>
		<% if(canEdit){ %>
		<tr>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<th colspan="2">
				<input type="button" value="수정하기" id="btn" onclick="updateBoard()">
				<input type="button" value="삭제하기" id="btn" onclick="deleteBoard()">
			</th>
		</tr>
		<% } %>
	</table>
	
	<hr style="margin-top:30px;" />	
    
	<div class="comment-container">
      <!--table#tbl-comment-->
		<% if (comments != null && !comments.isEmpty()) {%>
		<table id="tbl-comment">
			<tbody>
			<% 
				for (BoardComment bc : comments){ 
					boolean canDelete = loginMember != null 
							&& (loginMember.getMemberId().equals(bc.getMemberId()) 
									|| loginMember.getMemberRole() == MemberRole.A);
							
					if(bc.getCommentLevel() == 1){
			%>
				<tr class="level1">
					<td><%= bc.getMemberId() != null ? bc.getMemberId() : "(탈퇴회원)"%>
					<td><%= bc.getRegDate() %></td>
				<br />
					<%= bc.getContent() %>
					</td>
					<td>
						<button class="btn-reply" value="<%= bc.getNo() %>">답글</button>
						<% if(canDelete){ %>
							<button class="btn-delete" value="<%= bc.getNo() %>">삭제</button>
						<% } %>
					</td>
				</tr>
			<% 		} else { %>
				<tr class="level2">
						<td class="cwriterdate">
						<%= bc.getMemberId() != null ? bc.getMemberId() : "(탈퇴회원)" %>
						<br />
						<%= bc.getRegDate() %>
						<td class="cm-contents">
						<%= bc.getContent() %>
					</td>
					<td>
						<% if(canDelete){ %>
							<button class="btn btn-delete" value="<%= bc.getNo() %>">삭제</button>
						<% } %>
					</td>
				</tr>
			<% 
					}	
				} 
			%>
			</tbody>
		</table>
	</div>
	
		 <div class="comment-editor">
            <form
				action="<%=request.getContextPath()%>/board/boardCommentEnroll" method="post" 
				name="boardCommentFrm" id="#comment-h">
                <input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
                <input type="hidden" name="memberId" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
                <input type="hidden" name="commentLevel" value="1" />
                <input type="hidden" name="commentRef" value="0" />    
				<textarea name="content" cols="60" rows="3" placeholder="댓글을 작성하세요"></textarea>
                <button type="submit"  class="btn" id="btn-comment-enroll1">등록</button>
            </form>
        </div>
		<% } %>
</section>
	<hr style="margin-top:30px;" />	

<form action="<%=request.getContextPath()%>/board/boardCommentDelete" name="boardCommentDelFrm" method="POST">
	<input type="hidden" name="no" /> <!-- 댓글 번호 -->
	<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
</form>


<script>
/**
 * .btn-reply click eventhandler binding 
 */
document.querySelectorAll(".btn-delete").forEach((button) => {
	button.onclick = (e) => {
		if(!confirm("정말 삭제하시겠습니까?")) return;
		document.boardCommentDelFrm.no.value = e.target.value;
		document.boardCommentDelFrm.submit();
	}
});


// tbody > tr > td > .btn-reply
document.querySelectorAll(".btn-reply").forEach((button) => {
	button.onclick = (e) => {
		if(<%= loginMember == null %>){
			loginAlert();
			return;
		}
					
		const {value : commentRef} = e.target;
		console.log(commentRef);
		
		// tr > td > form 
		const tr = document.createElement("tr");
		const td = document.createElement("td");
		td.colSpan = "2";
		td.style.textAlign = "left";
		
		const frm = document.createElement("form");
		frm.name = "boardCommentFrm";
		frm.action = "<%=request.getContextPath()%>/board/boardCommentEnroll";
		frm.method = "POST";
		frm.onsubmit = commentSubmitHandler; // 동적생성한 요소는 핸들러바인딩도 새로 해야한다.
		
		const inputBoardNo = document.createElement("input");
		inputBoardNo.type = "hidden";
		inputBoardNo.name = "boardNo";		
		inputBoardNo.value = "<%= board.getNo() %>"
		const inputMemberId = document.createElement("input");
		inputMemberId.type = "hidden";
		inputMemberId.name = "memberId";
		inputMemberId.value = "<%= loginMember != null ? loginMember.getMemberId() : "" %>";
		const inputCommentLevel = document.createElement("input");
		inputCommentLevel.type = "hidden";
		inputCommentLevel.name = "commentLevel";
		inputCommentLevel.value = "2";
		const inputCommentRef = document.createElement("input");
		inputCommentRef.type = "hidden";
		inputCommentRef.name = "commentRef";
		inputCommentRef.value = commentRef;
			
		const textarea = document.createElement("textarea");
		textarea.name = "content";
		textarea.cols = "60";
		textarea.rows = "1";
		
		const button = document.createElement("button");
		button.className = "btn-comment-enroll2";
		button.innerText = "등록"
		
		frm.append(inputBoardNo);
		frm.append(inputMemberId);
		frm.append(inputCommentLevel);
		frm.append(inputCommentRef);
		frm.append(textarea);
		frm.append(button);
		td.append(frm);
		tr.append(td);
		
		// console.log(tr);
		// console.dir(td);
		
		// 1.부모요소 tbody
		const parent = e.target.parentElement.parentElement.parentElement;
		// console.log(parent); // td - tr - tbody
		// 2.기준요소 다음tr태그 
		const ref = e.target.parentElement.parentElement.nextElementSibling;
		// console.log(ref);
		
		// 생성된 tr 추가
		// parent.insertBefore(tr, ref);
		
		// target.insertAdjacentElement(position, newNode)
		// 1. beforebegin target의 이전 형제요소로 추가
		// 2. afterbegin target의 시작태그 다음에 자식요소로 추가
		// 3. beforeend target의 종료태그 직전에 자식요소로 추가
		// 4. afterend target의 다음 형제요소로 추가
		
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

document.boardCommentFrm.onsubmit = commentSubmitHandler;

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
	document.querySelector("#memberId").focus();
};

</script>

<% if(canEdit){ %>
<form action="<%= request.getContextPath() %>/board/boardDelete" name="boardDeleteFrm" method="POST">
	<input type="hidden" name="no" value="<%= board.getNo() %>" />
</form>
<script>
/**
 * POST /board/boardDelete
 * - no전송
 * - 저장된 파일 삭제 : java.io.File 
 */
const deleteBoard = () => {
	if(confirm("정말 이 게시글을 삭제하시겠습니까?"))
		document.boardDeleteFrm.submit();
};	

const updateBoard = () => {
	location.href = "<%= request.getContextPath() %>/board/boardUpdate?no=<%= board.getNo() %>";
}
</script>
<% } %>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	