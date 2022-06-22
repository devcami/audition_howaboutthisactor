<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/Dwishlist.css" />
<%
   // String memberId = 'hosi';
   // String memberId = loginMember.getMemberId();
   
   // char memberRole = 'P';
   // char memberRole = loginMember.getMemberRole();
   
	List<ActorInfo> list = (List<ActorInfo>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
%>
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Dmypage-submenu" class="submenu">
    <ul>
     <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>&memberRole=<%= loginMember.getMemberRole() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applicantList" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/companyInfo?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">담당자 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="mywish">
    <div>
      <div id="wishlist-head">
        <h2>찜 목록</h2>
        <div id="sortType-wrap">
        	<select id="sortType">
            	<option value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : ""%>>최신순</option>
            	<option value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : ""%>>오래된순</option>
          	</select>
 <!--          <select id="sortType">
          	<option value="allGender" id="allGender" <%="allGender".equals(sortType) ? "selected" : ""%>>전체</option>
            <option value="female" id="female" <%="female".equals(sortType) ? "selected" : ""%>>여성</option>
            <option value="male" id="male" <%="male".equals(sortType) ? "selected" : ""%>>남성</option>
          </select>  -->
        </div>
      </div>
            <div id="updown-container">
      <% if(list != null && !list.isEmpty()){
		for(int i = 0; i < list.size(); i++){ 
			String fileName = list.get(i).getAttachment().getRenamedFilename();
			String img_src = "";
			
	         if(fileName == null){
	             img_src = request.getContextPath() + "/images/default.png";
	          } else {
	             img_src = request.getContextPath() + "/upload/portfolio/" + fileName;         
	          }
	         
	         String name = list.get(i).getActorName() == null ? "" : list.get(i).getActorName();
	         String birth = list.get(i).getBirth() == null ? "" : list.get(i).getBirth();
	         int _age = list.get(i).getAge();
	    	 
	         String actor_age = _age != 0 ? Integer.toString(_age) : "";	
	    	 String age = "";
	    	 if(actor_age != null){
	    		if(birth.isEmpty()){ 
	    			age = _age + "세";
	    		} else {
	    			age = _age + "세";
	    			// age = "(" + _age + ")세";
	    		}
	    		
	    	 }
	    	 
	    	 String company = list.get(i).getCompany() == null ? "" : list.get(i).getCompany();
			
		%>
          <div class="card" onclick="actorView(this);">
            <div class="polaroid">
              <div class="img-container">
                <img src="<%= img_src %>" alt="">
              </div>
              <p class="actorName"><span class="highlight"><%= name %></span></p>
              <p class="actorBirth"><%= birth %></p>&nbsp;<p class="actorAge"><i><%= age %></i></p>
              <!-- <p class="company">컴패니 들어갈 자리</p> -->
              <input type="hidden" name="actorNo" id="actorNo" value="<%= list.get(i).getActorNo() %>">
            </div>
          </div>
        		<% 	} %>
		<% } else { %>
			<div><p>찜한 배우가 없습니다.</p></div>
		<% } %>
      </div>
	  <div id="pagebar">
	  	<%= pagebar %>
	  </div>
    </div>
  </div>

  <script>
  
  sortType.addEventListener('change', (e) => {
      document.querySelector("#updown-container").innerHTML = "";
      const {value} = e.target;
      // 공고 마감순 선택 시 페이지 요청
      location.href=`/app/mypage/DendDateWishList?sortType=\${value}`;
   });

   const actorView = (actor) => {
      	
	   const actorNo = actor.firstElementChild.lastElementChild.value;
	   
      // 배우 상세 페이지로 넘겨
      location.href=`/app/actor/actorView?actorNo=\${actorNo}`;
   };
  
    const mousein = (menu) => {
      now_menu.classList.remove('current');
      menu.classList.add('current');
    };

    const mouseout = (menu) => {
      now_menu.classList.add('current');
      menu.classList.remove('current');
    }
  </script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>