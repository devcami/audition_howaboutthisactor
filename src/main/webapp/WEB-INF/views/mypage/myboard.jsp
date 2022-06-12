<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/myboard.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio?memberId=<%= memberId %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwUpdate" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwDelete" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="myboard">
    <div>
      <h2>내가 쓴 게시글</h2>
      <table>
        <thead id="list-head">
          <tr>
            <th>글번호</th>
            <th>제목</th>
            <th>작성일</th>
          </tr>
        </thead>
        <tbody id="list-content">
          <tr>
            <td>1</td>
            <td>가나다</td>
            <td>220204</td>
          </tr>
          <tr>
            <td>2</td>
            <td>라마바</td>
            <td>220204</td>
          </tr>
          <tr>
            <td>3</td>
            <td>abc</td>
            <td>220202</td>
          </tr>
        </tbody>
      </table>
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