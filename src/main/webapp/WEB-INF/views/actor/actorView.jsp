<%@page import="wishlist.model.dto.WishListActor"%>
<%@page import="wishlist.model.dto.WishListAnn"%>
<%@page import="mypage.model.dto.PortfolioWork"%>
<%@page import="java.util.List"%>
<%@page import="mypage.model.dto.PortAttachment"%>
<%@page import="mypage.model.dto.ActorInfoExt"%>
<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %> 
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/actorView.css" />

<%
   PortAttachment profile = (PortAttachment) request.getAttribute("profile"); 
   ActorInfo actorInfo = (ActorInfo) request.getAttribute("actorInfo");
   List<PortfolioWork> pList = (List<PortfolioWork>) request.getAttribute("pList");
   
   List<WishListActor> wishlistActor = (List<WishListActor>) request.getAttribute("wishlistActor");
%>
<%
   String memberId = (String) request.getAttribute("memberId");
   String loginId = (String) request.getAttribute("loginId");
   int attachNo = (int) request.getAttribute("attachNo");
%>
<script>
const addWishlist = (e) => {
   const wishBtn = document.querySelector("#btn-wish-actor");
      let wishBtnSrc = wishBtn.lastElementChild.src;
      if(wishBtnSrc.substr(33,) == "fullHeartWish.png"){
         $.ajax({
            url : "<%= request.getContextPath() %>/actor/delWishActor",
            data : {
               actorNo : <%= actorInfo.getActorNo() %>,
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
            url : "<%= request.getContextPath() %>/actor/addWishActor",
            data : {
              actorNo : <%= actorInfo.getActorNo() %>,
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
</script>
<div class="top-logo">
   <span><%= actorInfo.getActorName() %></span>
</div>
<div id="btn-wish-actor" onclick="addWishlist(this);">
<% if(wishlistActor != null && !wishlistActor.isEmpty()){
      for(int i = 0; i < wishlistActor.size(); i++){
         if(wishlistActor.get(i).getActorNo() == actorInfo.getActorNo()){ 
         %>
         
            <img id="fullHeart" src="<%= request.getContextPath() %>/images/fullHeartWish.png" alt="" />
         <% break;
          } else if(i == wishlistActor.size() - 1) { %>
         <img id="emptyHeart" src="<%= request.getContextPath() %>/images/emptyHeartWish.png" alt="" />
        <% } %>
   <%    } %> 
<% } else { %>
      <img id="emptyHeartN"src="<%= request.getContextPath() %>/images/emptyHeartWish.png" alt="" />
<% } %>
</div>
<% if(profile != null && actorInfo != null && !pList.isEmpty()) { %>
<table id="portTable">
   <tbody>
      <tr>
         <th rowspan="9" id="img-th">대표사진</th>
         <td rowspan="9">
            <div id="profile-img-container">
               <img
                  src="<%= request.getContextPath() %>/upload/portfolio/<%= profile.getRenamedFilename() %>"
                  id="profile-img">
            </div>
         </td>
         <th>이름</th>
         <td colspan="3"><span><%= actorInfo.getActorName() %></span></td>
      </tr>
      <tr>
         <th>생년</th>
         <td style="width: 150px;"><span><%= actorInfo.getBirth() %></span>
         </td>
         <th style="text-align: right;">나이</th>
         <td><span><%= actorInfo.getAge() %>세</span></td>
      </tr>
      <tr>
         <th>소속사</th>
         <td colspan="3"><span><%= actorInfo.getCompany() %></span></td>
      </tr>
      <tr>
         <th>학력</th>
         <td colspan="3"><span><%= actorInfo.getEducation() %></span></td>
      </tr>
      <tr>
         <th>키</th>
         <td style="width: 150px;"><span><%= actorInfo.getHeight() %>cm</span>
         </td>
         <th style="text-align: right;">체중</th>
         <td><span><%= actorInfo.getWeight() %>kg</span></td>
      </tr>
      <tr>
         <th>휴대폰</th>
         <td colspan="3"><span><%= actorInfo.getPhone() %></span></td>
      </tr>
      <tr>
         <th>이메일</th>
         <td colspan="3"><span><%= actorInfo.getEmail() %></span></td>
      </tr>
      <tr>
         <th>SNS</th>
         <td colspan="3"><span><%= actorInfo.getSns() %></span></td>
      </tr>
      <tr>
         <th>특기</th>
         <td colspan="3"><span><%= actorInfo.getSpeciality() %></span></td>
      </tr>


      <tr>
         <td><br></td>
      </tr>
   </tbody>

   <tbody id="addWork-tbody">
      <tr>
         <th colspan="2" id="work-wrap-th">경력</th>
         <td colspan="4" style="text-align: right;"></td>
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
            <img class="work-img"
               src="<%= request.getContextPath() %>/upload/portfolio/<%= pList.get(i).getAttachment().getRenamedFilename() %>"
               alt="작품사진<%= i + 1 %>"
               value="<%= pList.get(i).getNo() %>"
               onclick="viewWork(this);"
               style="cursor: pointer;"/>
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
         <% if(memberId.equals(loginId)) {%>
            <div> <br><br><br>
            <input  class="btn-move" type="button"  value="포트폴리오 수정하기"onClick="myPage()"/>
            </div> <br><br>
         <% } %>
<% } %>
  <form name="viewWorkFrm" action="<%= request.getContextPath() %>/mypage/workView">
  	<input type="hidden" name="selectedWorkNo" id="selectedWorkNo"/>
  	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
  </form>
<script>

const viewWork = (e) => {		
	
	const workNo = e.getAttribute('value');
	document.getElementById("selectedWorkNo").value = workNo;
	console.log($('#selectedWorkNo').val())

	
		const title = "viewWorkPopup";
		const spec = "width=1000px, height=700px";
		const popup = open("", title, spec);
	
		const frm = document.viewWorkFrm;
		frm.target = title; // 해당 팝업에서 폼을 제출 
		frm.submit();
	
}





function myPage() {
	  window.location.href = 'http://localhost:9090/app/mypage/gotoEditPortfolio?memberId=<%= memberId %>&portType=exist&attachNo=<%= attachNo %>'
}


function myPage() {
     window.location.href = 'http://localhost:9090/app/mypage/gotoEditPortfolio?memberId=<%= memberId %>&portType=exist&attachNo=<%= attachNo %>'
}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
