<%@page import="java.sql.Date"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/Pwishlist.css" />
<%
   
	List<Ann> list = (List<Ann>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
%>

<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist?memberId=<%= loginMember.getMemberId() %>" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  
  <div id="mywish">
    <div>
      <div id="wishlist-head">
        <h2>찜 목록</h2>
        <div id="sortType-wrap">
          <select id="sortType">
            <option value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : ""%>>최신순</option>
            <option value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : ""%>>마감순</option>
          </select>
        </div>
      </div>
      <div id="updown-container">
      <% if(list != null && !list.isEmpty()){
    		long miliseconds = System.currentTimeMillis();
    	    Date today = new Date(miliseconds);
    	    
			for(int i = 0; i < list.size(); i++){ 
				
				if(list.get(i).getAnnEndDate().before(today)){ 
		%>
			        <div class="col">
			          <div class="card expirated"> <!--  onclick="annView(this);" -->
			            <div class="card-body">
			              <h5 class="card-title"><%= list.get(i).getAnnTitle() %></h5>
			              <p class="card-text"><%= list.get(i).getMemberId() %></p>
			              <input type="hidden" name="annNo" id="annNo" value="<%= list.get(i).getAnnNo() %>">
			            </div>
			            <div class="card-footer expFoot">
			              <small class="text-muted"><%= list.get(i).getAnnRegDate() %></small> ~ 
			              <small class="text-muted"><%= list.get(i).getAnnEndDate() %>(마감)</small>
			            </div>
			          </div>
			        </div>
	       
        	<% 	} else { %>
		        	<div class="col">
			          <div class="card" onclick="annView(this)"> <!--  onclick="annView(this);" -->
			            <div class="card-body">
			              <h5 class="card-title"><%= list.get(i).getAnnTitle() %></h5>
			              <p class="card-text"><%= list.get(i).getMemberId() %></p>
			              <input type="hidden" name="annNo" id="annNo" value="<%= list.get(i).getAnnNo() %>">
			            </div>
			            <div class="card-footer">
			              <small class="text-muted"><%= list.get(i).getAnnRegDate() %></small> ~ 
			              <small class="text-muted"><%= list.get(i).getAnnEndDate() %></small>
			            </div>
			          </div>
			        </div>
	<%  		}
			}		
	    } else {
	%>
		<p>찜한 공고가 없습니다.</p>
		
	<% } %>
      </div>
    </div>
	<div id="pagebar">
		<%= pagebar %>
	</div>
  </div>

  <script>
  sortType.addEventListener('change', (e) => {
      document.querySelector("#updown-container").innerHTML = "";
      const {value} = e.target;
      // 공고 마감순 선택 시 페이지 요청
      location.href=`/app/mypage/PendDateWishList?sortType=\${value}`;
   });

  const annView = (ann) => {
	  console.log(ann);
      const annNo = ann.firstElementChild.lastElementChild.value;
      //const annNo = ann.currentTarget.firstElementChild.children.annNo.value;
      console.log(annNo);
   	  location.href=`/app/ann/annView?annNo=\${annNo}`;
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