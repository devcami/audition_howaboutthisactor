<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@page import="java.sql.Date"%>
<%@page import="member.model.dto.Production"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="common.model.dto.Cast"%>
<%@page import="common.model.dto.WorkAttachment"%>
<%@page import="java.util.List"%>
<%@page import="common.model.dto.Work"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<% 
	Ann ann = (Ann) request.getAttribute("ann");
	Work work = ann.getWork();
	List<WorkAttachment> workAttachments = work.getAttachments();
	Cast cast = work.getCast();
	Production p = (Production) request.getAttribute("production");
	
	Date birthday = Date.valueOf("1990-09-09");
	Date enrollDate = Date.valueOf("2022-06-10");
	Member loginMember = new Member("director", "1234", "디렉터샘플", "director@naver.com", MemberRole.D, "01015971597", "M", birthday, enrollDate);
	
	boolean canEdit = loginMember != null 
			&& (loginMember.getMemberId().equals(ann.getMemberId()) 
					|| loginMember.getMemberRole() == MemberRole.A);
%>
<section id="ann-view-container">
	<div class="container">
		<div class="ann-info mrgbtm">
			<h1 id="ann-title"><%= ann.getAnnTitle() %></h1>
			<span id="cast-role"><%= cast.getCastRole() %></span>&nbsp;|&nbsp;<span id="cast-name"><%= cast.getCastName() %>역</span>
			<h5 id="work-title"> <%= work.getProduction() %>&nbsp;|&nbsp;<%= work.getDirector() %>&nbsp;|&nbsp;<<%= work.getTitle() %>> </h5>
			<p><%= ann.getAnnEndDate() %> 마감 | <%= ann.getAnnRegDate() %> 게시</p>
			<button id="btn-apply" class="rounded">간편지원</button>
			<div id="btn-wish"><img src="<%= request.getContextPath() %>/images/emptyHeartWish.png" alt="" /></div>
			
		</div>
		<div class="work-info mrgbtm">
			<h2>작품 정보</h2>
			<table class="table table-borderless" id="tbl-work-info">
			<tbody>
				<tr>
					<th>작품 제목</th>
					<td><%= work.getTitle() %></td>
				</tr>
				<tr>
					<th>작품 분야</th>
					<td><%= work.getWorkField() %></td>
				</tr>
				<tr>
					<th>감독</th>
					<td><%= work.getDirector() %></td>
				</tr>
				<tr>
					<th>제작사</th>
					<td><%= work.getProduction() %></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><%= cast.getCastName() %></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
					<% if(p.getIsPhoneOpen().equals("Y")){ %>
							<%= p.getCasterPhone() %>			
					<% 	} else { %>
							비공개
					<% } %>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
					<% if(p.getIsEmailOpen().equals("Y")){ %>
							<%= p.getCasterEmail() %>			
					<% 	} else { %>
							비공개
					<% } %>
					</td>
				</tr>
			</tbody>
			</table>
		</div>	
		<hr />
		<div class="work-content mrgbtm">
			<h2>작품 설명</h2>
			<p>
				<%= work.getDescription() %>
			</p>
		</div>
		<hr />
		<div class="cast-info mrgbtm">
			<h2>배역 정보</h2>
			<div class="accordion" id="accordionPanelsStayOpenExample">
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button" type="button"
							data-bs-toggle="collapse"
							data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
							aria-controls="panelsStayOpen-collapseOne">
						<%= cast.getCastRole() %> • <%= cast.getCastName() %> 역 
						<br />
						<%= ann.getAnnAge() %> | <%= ann.getAnnGender() %> | <%= ann.getAnnNop() %>명	
						</button>
					</h2>
					<div id="panelsStayOpen-collapseOne"
						class="accordion-collapse collapse show"
						aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body">
							<table class="table table-borderless" id="tbl-cast-info">
							<tbody>
								<tr>
									<th>배역 이름</th>
									<td><%= cast.getCastName() %> 역 (<%= cast.getCastRole() %>)</td>
								</tr>
								<tr class="underline">
									<th>모집 인원</th>
									<td><%= ann.getAnnNop() %>명</td>
								</tr>
								<tr>
									<th>기본 조건</th>
									<td><%= ann.getAnnAge() %> | <%= ann.getAnnGender() %> </td>
								</tr>
								<tr class="underline">
									<th>신체 조건</th>
									<td><%= ann.getAnnHeight() %> | <%= ann.getAnnBody() %> </td>
								</tr>
								<tr>
									<th>출연료</th>
									<td><%= ann.getAnnPay() %></td>
								</tr>
								<tr class="underline">
									<th>촬영 지역</th>
									<td><%= ann.getAnnArea() %></td>
								</tr>
								<tr>
									<th>배역 설명</th>
									<td><%= cast.getCastContents() %></td>
								</tr>
							</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr />
		<div class="attachments mrgbtm">
			<h2>사진 및 동영상</h2>
			<%
			if(workAttachments != null && !workAttachments.isEmpty()){
				for(WorkAttachment wa : workAttachments){ %>
					<figure class="figure">
						<!-- 첨부파일 있는 경우 img에 파일명 -->
						<img src="<%= request.getContextPath() %>/upload/ann/<%= wa.getRenamedFilename() %>" class="figure-img img-fluid rounded" alt="첨부파일" style="width:280px">
					</figure>
			<%				
				}
			}
			%>
		</div>
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#exampleModal" id="btn-report">신고하기</button>

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">신고</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="message-text" class="col-form-label">신고자:</label>
							<input type="text" name="report-writer" id="report-writer" value="loginMember.getMemberId()" readonly>
						</div>
						<div class="mb-3">
							<label for="message-text" class="col-form-label">신고내용:</label>
							<textarea class="form-control" id="content"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="btn-report-submit">제출</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</section>
<script>
/**
 * 지원하기 버튼 클릭 시 지원 폼 요청
 */
const btnApply = document.querySelector("#btn-apply"); 
btnApply.addEventListener('click', (e) => {
	//console.log(e.target);
});

/**
 * 마감된 공고일 시 지원하기 버튼 비활성화 
 */
<%
if(ann.getIsClose().equals("Y")){
%>
	btnApply.innerText = "모집 마감";
	btnApply.style.backgroundColor = "gainsboro";
	btnApply.style.boxShadow = "none";
	btnApply.disabled = 'disabled';
<%	
}
%>

/**
 *  신고하기
 */
document.querySelector("#btn-report-submit").addEventListener('click', (e) => {
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	const contentVal = content.value.trim(); 
	console.log(contentVal);
	if(!/^(.|\n)+$/.test(contentVal)){ //아무글자(.)가 아닌 개행문자가 있어서 인식못함. -> (.|\n)으로 바꿔줘야 함.
		alert('내용을 작성해주세요.');				
		content.select();
		return false;
	}
	
	if(confirm('신고내역을 제출하시겠습니까?')){
		console.log('신고진행');
	}
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
