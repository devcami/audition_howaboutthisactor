<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>   
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/noticeEnroll.css" />

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
			<h2>공지글 작성</h2>
		<form
			name="noticeEnrollFrm"
			action="<%=request.getContextPath() %>/notice/noticeEnroll" 
			method="post">
			<table id="tbl-board-view">
				<tr>
					<th>제 목</th>
						<td>
						<input type="text" name="title" required>
						</td>
				</tr>
				<tr>
					<th>작성자</th>
						<td>
							<input type="text" name="memberId" value="<%= loginMember.getMemberId() %>" readonly/>
						</td>
				<tr>
					<th>내 용</th>
						<td>
						<textarea onkeyup="adjustHeight();" id="content" name="content"></textarea>
						</td>
				</tr>
			</table>
		</form>
	</div>
		<div>
		<button style="float:right;" id="btn-submit" class="btn" type="button" onclick="enrollSubmit(this);">등록하기</button>
		</div>
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
const enrollSubmit = (e) => {
	if(confirm('공지를 등록하시겠습니까?')){
		document.noticeEnrollFrm.submit();
	}
};


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
