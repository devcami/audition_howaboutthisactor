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
%>
<section id="ann-view-container">
	<div class="container">
		<div class="ann-info mrgbtm">
			<h1 id="ann-title"><%= ann.getAnnTitle() %></h1>
			<span id="cast-role"><%= cast.getCastRole() %></span>&nbsp;|&nbsp;<span id="cast-name"><%= cast.getCastName() %>역</span>
			<h5 id="work-title"> <%= work.getProduction() %>&nbsp;|&nbsp;<%= work.getDirector() %>&nbsp;|&nbsp;<<%= work.getTitle() %>> </h5>
			<p><%= ann.getAnnEndDate() %> 마감 | <%= ann.getAnnRegDate() %> 게시</p>
			<button id="btn-apply" class="rounded">간편지원</button>
			<div id="btn-wish">찜하트</div>
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
					<td>공고등록 시 작성자의 회사정보에 caster_name</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>공고등록 시 작성자의 회사정보에 caster_phone</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>공고등록 시 작성자의 회사정보에 caster_email</td>
				</tr>
			</tbody>
			</table>
		</div>	
		<hr />
		<div class="work-content mrgbtm">
			<h2>작품 설명</h2>
			<p>
				<%= work.getDescription() %>
				Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima quae consequatur est iste unde rem fuga impedit perspiciatis voluptas et quibusdam quisquam delectus obcaecati quos atque aliquam pariatur amet nostrum.
				Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur doloribus facere dolore qui placeat commodi ab sed saepe vero dolor dignissimos cupiditate expedita nemo praesentium maiores natus sint tempora iusto?
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
						<%= ann.getAnnAge() %> | <%= ann.getAnnGender() %> 	
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
									<td><%= cast.getCastName() %>역 (<%= cast.getCastRole() %>)</td>
								</tr>
								<tr>
									<th>기본 조건</th>
									<td><%= ann.getAnnAge() %> | <%= ann.getAnnGender() %> </td>
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
						<!-- src="request.getContextPath()/upload/board/wa.getName?" -->
						<img src="<%= request.getContextPath() %>/images/annViewPageTestPic.jpg" class="figure-img img-fluid rounded" alt="첨부파일">
						<figcaption class="figure-caption">이미지에 대한 설명</figcaption>
					</figure>
					<figure class="figure">
						<!-- 첨부파일 있는 경우 img에 파일명 -->
						<img src="<%= request.getContextPath() %>/images/annViewPageTestPic.jpg" class="figure-img img-fluid rounded" alt="첨부파일">
						<figcaption class="figure-caption">이미지에 대한 설명2</figcaption>
					</figure>
					<figure class="figure">
						<!-- 첨부파일 있는 경우 img에 파일명 -->
						<img src="<%= request.getContextPath() %>/images/annViewPageTestPic.jpg" class="figure-img img-fluid rounded" alt="첨부파일">
						<figcaption class="figure-caption">이미지에 대한 설명3</figcaption>
					</figure>
			<%				
				}
			}
			%>
		</div>
	</div>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
