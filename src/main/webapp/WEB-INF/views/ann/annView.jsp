<%@page import="mypage.model.dto.ActorInfoExt"%>
<%@page import="mypage.model.dto.PortfolioWork"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="mypage.model.dto.PortAttachment"%>
<%@page import="wishlist.model.dto.WishListAnn"%>
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
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/annApply.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
<% 
   Ann ann = (Ann) request.getAttribute("ann");
   Work work = ann.getWork();
   List<WorkAttachment> workAttachments = work.getAttachments();
   Cast cast = work.getCast();
   Production p = (Production) request.getAttribute("production");
   
   
   PortAttachment profile = (PortAttachment) request.getAttribute("profile"); 
   ActorInfo actorInfo = (ActorInfo) request.getAttribute("actorInfo");
   List<PortfolioWork> pList = (List<PortfolioWork>) request.getAttribute("pList");
   
   List<WishListAnn> wishlistAnn = (List<WishListAnn>) request.getAttribute("wishlistAnn");

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
			<% if(loginMember != null && loginMember.getMemberRole().toString().equals("P")) { %>			
				<button type="button" id="btn-apply" class="rounded view" data-bs-toggle="modal" data-bs-target="#applyModal" >간편지원</button>
	
			<!-- Modal -->
			<div class="modal fade" id="applyModal" tabindex="-1"
				aria-labelledby="applyModalLabel" aria-hidden="true">
				<div class="modal-dialog" id="applyModalContent">
					<div class="modal-content" >
						<div class="modal-header">
							<h5 class="modal-title" id="applyModalLabel">간편 지원 : 나의 포트폴리오</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<form name="annApplyFrm" 
							action="<%= request.getContextPath() %>/ann/annApply"
							method="POST">
							<input type="hidden" name="annNoApply" value="<%= ann.getAnnNo() %>">
							<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>">
							<div class="modal-body">
							<% if(profile != null && actorInfo != null && !pList.isEmpty()) { %>
							     <table id="portTable">
							        <tbody>
							          <tr>
							            <th rowspan="9" id="img-th">대표사진</th>
							            <td rowspan="9">
							              <div id="profile-img-container">
							                <img src="<%= request.getContextPath() %>/upload/portfolio/<%= profile.getRenamedFilename() %>" id="profile-img">
							              </div>
							            </td>
							            <th>이름</th>
							            <td colspan="3">
							              <span><%= actorInfo.getActorName() %></span>
							            </td>
							          </tr>
							          <tr>
							            <th>생년</th>
							            <td style="width: 150px;">
							            	<span><%= actorInfo.getBirth() %></span>
							            </td>
							            <th style="text-align: right;">나이</th>
							            <td>
							            	<span><%= actorInfo.getAge() %>세</span>
							            </td>
							          </tr>
							          <tr>
							            <th>소속사</th>
							            <td colspan="3">
							            	<span><%= actorInfo.getCompany() %></span>
							            </td>
							          </tr>
							          <tr>
							            <th>학력</th>
							            <td colspan="3">
							            	<span><%= actorInfo.getEducation() %></span>
							            </td>
							          </tr>
							          <tr>
							            <th>키</th>
							            <td style="width: 150px;">
							              <span><%= actorInfo.getHeight() %>cm</span>
							            </td>
							            <th style="text-align: right;">체중</th>
							            <td>
							            	<span><%= actorInfo.getWeight() %>kg</span>
							            </td>
							          </tr>
							          <tr>
							            <th>휴대폰</th>
							            <td colspan="3">
							            	<span><%= actorInfo.getPhone() %></span>
							            </td>
							          </tr>
							          <tr>
							            <th>이메일</th>
							            <td colspan="3">
							              <span><%= actorInfo.getEmail() %></span>
							            </td>
							          </tr>
							          <tr>
							            <th>SNS</th>
							            <td colspan="3">
							            	<span><%= actorInfo.getSns() %></span>
							            </td>
							          </tr>
							          <tr>
							            <th>특기</th>
							            <td colspan="3">
							            	<span><%= actorInfo.getSpeciality() %></span>
							            </td>
							          </tr>
							          
							          
							          <tr>
							            <td><br></td>
							          </tr>
							        </tbody>
							        
							        <tbody id="addWork-tbody">
							    	  <tr>
							              <th colspan="2" id="work-wrap-th">경력</th>
							              <td colspan="4" style="text-align:right;">
							              </td>
							          </tr>
							          <tr>
							            <td colspan="6" style="border-top: 1px solid grey;"></td>
							          </tr>
							          <tr>
							          	<td><br /></td>
							          </tr>
									</tbody>
									<% for(int i = 0; i < pList.size(); i++){ %>
									<tbody id="work<%= pList.get(i).getNo() %>"></tbody>
										<tr>
											<th rowspan="5" class="work-no"><span><%= i + 1 %></span></th>
											<td rowspan="5">
												<div id="work-img-container">
													<img class="work-img" src="<%= request.getContextPath() %>/upload/portfolio/<%= pList.get(i).getAttachment().getRenamedFilename() %>" alt="작품사진<%= i + 1 %>" />
												</div>
											</td>
										</tr>
										<tr class="work-tr">
											<th>작품명</th>
											<td colspan="3"><%= pList.get(i).getTitle() %></td>
										</tr>
										<tr class="work-tr">
											<th>배역</th>
											<td colspan="3"><%= pList.get(i).getMyrole() %></td>
										</tr>
										<tr class="work-tr">
											<th>기간</th>
											<td colspan="3"><%= pList.get(i).getPeriod() %></td>
										</tr>
										<tr>
							            	<td colspan="6" style="border-top: 1px solid grey;"></td>
							         	</tr>
									</tbody>
									<% }%>
							      </table>	
							      <% } %>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								<a href="<%= request.getContextPath() %>/mypage/portfolio?memberId=<%= loginMember.getMemberId() %>&memberRole=<%= loginMember.getMemberRole() %>" role="button" class="btn btn-secondary" >포트폴리오 작성하러 가기</a>
								<button type="button" onclick="ApplySubmit();" class="btn" id="btn-apply-submit">제출</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		<% } %>
			<div id="btn-wish" onclick="addWishlist(this);">
			<% if(wishlistAnn != null && !wishlistAnn.isEmpty()){
					for(int i = 0; i < wishlistAnn.size(); i++){
						if(wishlistAnn.get(i).getAnnNo() == ann.getAnnNo()){ %>
						   <img id="fullHeart" src="<%= request.getContextPath() %>/images/fullHeartWish.png" alt="" />
						<% break;
				 		} else if(i == wishlistAnn.size() - 1) { %>
						<img id="emptyHeart" src="<%= request.getContextPath() %>/images/emptyHeartWish.png" alt="" />
				 	 <% } %>
				<% 	} %> 
			<% } else { %>
					<img id="emptyHeartN"src="<%= request.getContextPath() %>/images/emptyHeartWish.png" alt="" />
			<% } %>
			</div>
			
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
					<td><%= work.getDirector() %> 감독</td>
				</tr>
				<tr>
					<th>제작사</th>
					<td><%= work.getProduction() %></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><%= p.getCasterName() %></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
					<% if(p.getIsPhoneOpen().equals("Y")){ %>
							<%= p.getCasterPhone() %>			
					<% } else { %> 비공개 <% } %>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
					<% if(p.getIsEmailOpen().equals("Y")){ %>
						<%= p.getCasterEmail() %>			
					<% } else { %> 비공개 <% } %>
					</td>
				</tr>
			</tbody>
			</table>
		</div>	
		<hr />
		<div class="work-content mrgbtm">
			<h2>작품 설명</h2>
			<p class="workD">
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
									<td><%= ann.getAnnAge() %> | <%= ann.getAnnGender() %> <%= ann.getHasTO().equals("Y") ? "| 노출장면 있음" : "" %></td>
									
								</tr>
								<tr class="underline">
									<th>신체 조건</th>
									<td><%= ann.getAnnHeight() != null ? (ann.getAnnHeight().equals("선택해주세요") ? "" : ann.getAnnHeight()) : "" %> 
									| <%= ann.getAnnBody() != null ? (ann.getAnnBody().equals("선택해주세요") ? "" : ann.getAnnBody()) : "" %> </td>
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
									<td><%= cast.getCastContents() != null ? cast.getCastContents() : ""%></td>
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
			<% } %>
		<% } %>
		</div>
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary view" data-bs-toggle="modal"
			data-bs-target="#reportModal" id="btn-report">신고하기</button>


      <!-- Modal -->
      <div class="modal fade" id="reportModal" tabindex="-1"
         aria-labelledby="reportModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="reportModalLabel">신고</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal"
                     aria-label="Close"></button>
               </div>
               <form name="annReportFrm" 
                  action="<%= request.getContextPath() %>/ann/annReport"
                  method="POST">
                  <input type="hidden" name="annNoReport" value="<%= ann.getAnnNo() %>">
                  <div class="modal-body">
                     <div class="mb-3">
                        <label for="message-text" class="col-form-label">신고자:</label>
                        <input type="text" name="reportWriter" id="report-writer" value="<%= loginMember.getMemberId() %>" readonly>
                     </div>
                     <div class="mb-3">
                        <label for="message-text" class="col-form-label">신고내용:</label>
                        <textarea class="form-control" name="reportContent" id="content"></textarea>
                     </div>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary" id="btn-report-submit" >제출</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
      <% if(canEdit){ %>
            <input type="button" value="삭제하기" class="btn-delete view" id="btn-delete" onclick="deleteAnn()">
            <input type="button" value="수정하기" class="btn-update view" id="btn-update" onclick="updateAnn()">
      <% } %>
   </div>

</section>
<script>
/**
 * 포트폴리오 제출 버튼 클릭 시 제출 & 이미 한것 
 */
const ApplySubmit = () => {
   let applyList;
   if(confirm('포트폴리오를 제출하시겠습니까?')){
      $.ajax({
         url : "<%= request.getContextPath() %>/ann/getApplyList",
         data : {
            "memberId" : "<%= loginMember.getMemberId() %>"   
         },
         success(resp){
            let cnt = 0;
            if(resp != null && resp.length > 0){
               for(let i = 0; i < resp.length; i++){
                  const {applyAnnNo} = resp[i];
                  if(applyAnnNo == <%= ann.getAnnNo() %>){
                     alert('이미 지원한 공고입니다.');         
                     break;
                  } else {
                     cnt++;
                  }
                  
                  if(cnt == resp.length){
                     document.annApplyFrm.submit();
                     alert('공고 지원이 완료되었습니다.');
					 sendEmail();
                  }
               }
                  
            } else {
            	document.annApplyFrm.submit();
				alert('공고 지원이 완료되었습니다.');
				sendEmail();
            }
         },
         error : console.log,
         complete(){
         }
      });
   }
};

(function(){
	emailjs.init("qr-nmLS4V0i4h59Yx");		
})();

const sendEmail = () => {
	var templateParams = {	
		director: "<%= p.getCasterName() %>",
		annTitle: "<%= ann.getAnnTitle() %>",
		directorEmail: "<%= p.getCasterEmail() %>"
	};
                    
	emailjs.send('service_r6ea1ha', 'template_hxvvope', templateParams)
		.then(function(response) {
			console.log('SUCCESS!', response.status, response.text);
		}, function(error) {
			console.log('FAILED...', error);
		});
}

/**
 * 하트 클릭 시 wishlist_ann에 추가 | 삭제 비동기
 */
 const addWishlist = (e) => {
	   const wishBtn = document.querySelector("#btn-wish");
	   let wishBtnSrc = wishBtn.lastElementChild.src;
	   if(wishBtnSrc.substr(33,) == "fullHeartWish.png"){
	      $.ajax({
	         url : "<%= request.getContextPath() %>/ann/delWishAnn",
	         data : {
	            annNo : <%= ann.getAnnNo() %>,
	            memberId : "<%= loginMember.getMemberId() %>"
	         },
	         success(resp){
	            //하트가 empty로
	            wishBtn.lastElementChild.src = "<%= request.getContextPath() %>/images/emptyHeartWish.png";
	         },
	         error : console.log
	      });
   } else {
      $.ajax({
         url : "<%= request.getContextPath() %>/ann/addWishAnn",
         data : {
            annNo : <%= ann.getAnnNo() %>,
            memberId : "<%= loginMember.getMemberId() %>"
         },
         success(resp){
            //하트가 full로
            wishBtn.lastElementChild.src = "<%= request.getContextPath() %>/images/fullHeartWish.png";
         },
         error : console.log
      });
   }
};

/**
 * 마감된 공고일 시 지원하기 버튼 비활성화 
 */
 
const annEndDate = "<%= ann.getAnnEndDate() %>";
const today = new Date();
const endDate = new Date(annEndDate);
const btnApply = document.querySelector("#btn-apply");
if(endDate < today){ 
	console.log(today, annEndDate);
	btnApply.innerText = "모집 마감";
	btnApply.style.backgroundColor = "gainsboro";
	btnApply.style.boxShadow = "none";
	btnApply.disabled = 'disabled';
}

/**
 *  신고하기 300자 이내
 */
$(content).keyup(function(e) {
   let content = $(this).val();
   if(content.length > 300){
      alert("신고 내용은 최대 300자까지 입력 가능합니다.");
      $(this).val(content.substring(0, 300));
      $(this).focus();
   }
});
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

<%-- 수정하기 삭제하기 --%>
<% if(canEdit) { %>
<form 
   name="annDelFrm" 
   action="<%= request.getContextPath() %>/ann/annDelete"
   method="POST">
   <input type="hidden" name="annNo" value="<%= ann.getAnnNo() %>" />
</form> 
<script>
const deleteAnn = () => {
   if(confirm('확인을 누르시면 되돌이킬 수 없습니다. 공고를 삭제하시겠습니까?'))
      document.annDelFrm.submit();
}
const updateAnn = () => {
   location.href = "<%= request.getContextPath() %>/ann/annUpdate?annNo=<%= ann.getAnnNo() %>"; 
}
</script>
<% } %>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>