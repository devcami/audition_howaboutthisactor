<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/Dwishlist.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Dmypage-submenu" class="submenu">
    <ul>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 관리</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="mywish">
    <div>
      <h2>찜 목록</h2>
      <div id="updown-container">
        <div id="up">
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi2.jpg" alt="">
              </div>
              <p class="actorName">이준영</p>
              <p class="actorBirth">1997-01-22</p>
            </div>
          </div>
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi7.jpg" alt="">
              </div>
              <p class="actorName">호시</p>
              <p class="actorBirth">1996-06-15</p>
            </div>
          </div>
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/lee2.jpg" alt="">
              </div>
              <p class="actorName">이준영</p>
              <p class="actorBirth">1997-01-22</p>
            </div>
          </div>
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi8.jpg" alt="">
              </div>
              <p class="actorName">호시</p>
              <p class="actorBirth">1996-06-15</p>
            </div>
          </div>
        </div>
        <div id="down">
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi6.jpg" alt="">
              </div>
              <p class="actorName">이준영</p>
              <p class="actorBirth">1997-01-22</p>
            </div>
          </div>
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi5.jpg" alt="">
              </div>
              <p class="actorName">호시</p>
              <p class="actorBirth">1996-06-15</p>
            </div>
          </div>
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi2.jpg" alt="">
              </div>
              <p class="actorName">이준영</p>
              <p class="actorBirth">1997-01-22</p>
            </div>
          </div>
          <div class="card">
            <div class="polaroid">
              <div class="img-container">
                <img src="./img/hosi4.jpg" alt="">
              </div>
              <p class="actorName">호시</p>
              <p class="actorBirth">1996-06-15</p>
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


  </div>

  <script>
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