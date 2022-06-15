<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberlist.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원조회</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/reportList" onmouseover="mousein(this);" onmouseout="mouseout(this)">신고내역</a></li>
    </ul>
  </div>
  <div id="myboard">
    <div>
      <div id="myann_head">
        <h2>회원 조회</h2>
        <div id="condition">
          <select name="searchType" id="searchType">
            <option value="memberId">아이디</option>
            <option value="memberType">회원유형</option>
            <option value="memberName">회원명</option>
          </select>
          <div id="search-memberId" class="search-type">
            <form action="/mvc/admin/memberFinder">
              <input type="hidden" name="searchType" value="memberId">
              <input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 아이디를 입력하세요.">
              <button type="submit" class="btn">검색</button>
            </form>
          </div>
          <div id="search-memberType" class="search-type">
            <form action="/mvc/admin/memberFinder">
              <input type="hidden" name="searchType" value="memberType">
              <input type="radio" name="searchKeyword" value="P" class="radio-btn">P
              <input type="radio" name="searchKeyword" value="D" class="radio-btn">D
              <button type="submit" class="btn">검색</button>
            </form>
          </div>
          <div id="search-memberName" class="search-type">
            <input type="hidden" name="searchType" value="memberName">
            <input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 이름을 입력하세요.">
            <button type="submit" class="btn">검색</button>
          </div>
        </div>
      </div>
      <table>
        <thead id="list-head">
          <tr>
            <th>아이디</th>
            <th>회원유형</th>
            <th>이름</th>
            <th>이메일</th>
            <th>가입일</th>
          </tr>
        </thead>
        <tbody id="list-content">
          <tr>
            <td>sinsa</td>
            <td>D</td>
            <td>신사임당</td>
            <td>sinsa@gmail.com</td>
            <td>2022-09-05</td>
          </tr>
          <tr>
            <td>honggd</td>
            <td>P</td>
            <td>홍길동</td>
            <td>honggd11@naver.com</td>
            <td>2020-05-12</td>
          </tr>
          <tr>
            <td>abc</td>
            <td>P</td>
            <td>사과</td>
            <td>abc123@naver.com</td>
            <td>2022-12-13</td>
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

    searchType.addEventListener('change', (e) => {
      const {value} = e.target;

      document.querySelectorAll('.search-type').forEach((div) => {
        div.style.display = "none";
      });
      let id = "";
      switch(value) {
        case "memberId": id = "search-memberId"; break;
        case "memberType": id = "search-memberType"; break;
        case "memberName": id = "search-memberName"; break;
      }
      document.querySelector(`#${id}`).style.display = "inline-block";
    });
  </script>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>