<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/Pwishlist.css" />
<%
   // String memberId = 'hosi';
   // String memberId = loginMember.getMemberId();
   
   // char memberRole = 'P';
   // char memberRole = loginMember.getMemberRole();
%>

<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio?memberId=<%= memberId %>"  onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboard" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwUpdate" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwDelete" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  
<div id="mywish">
    <div>
      <div id="wishlist-head">
        <h2>찜 목록</h2>
        <div id="sortType-wrap">
          <select id="sortType">
            <option value="reg_date" id="reg_date">최신순</option>
            <option value="end_date" id="end_date">마감순</option>
          </select>
        </div>
      </div>
      <div id="updown-container">
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">테스트제목6</h5>
              <p class="card-text">director</p>
              <input type="hidden" name="annNo" id="annNo" value="23">
            </div>
            <div class="card-footer">
              <small class="text-muted">2022-06-07</small> ~ 
              <small class="text-muted">2022-06-12</small>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="pagebar">
      <a href='/mvc/admin/memberList?cPage=1' class="page">1</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">2</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">3</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">4</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">5</a>
      <a href='/mvc/admin/memberList?cPage=6' class="page">next</a>
    </div>

  </div>

  <script>
  sortType.addEventListener('change', (e) => {
      document.querySelector("#ann-container").innerHTML = "";
      const {value} = e.target;
      // 공고 마감순 선택 시 페이지 요청
      location.href=`/app/ann/annList?sortType=${value}`;
   });

   const annView = (ann) => {
      const annNo = ann.firstElementChild.lastElementChild.value;
      location.href=`/app/ann/annView?annNo=${annNo}`;
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