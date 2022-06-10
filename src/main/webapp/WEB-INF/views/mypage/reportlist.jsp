<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/reportlist.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원조회</a></li>
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">신고내역</a></li>
    </ul>
  </div>
  <div id="myboard">
    <div>
      <div id="myann_head">
        <h2>신고 내역</h2>
        <div id="condition">
          <select name="searchType" id="searchType">
            <option value="default">처리상태</option>
            <option value="undo">접수</option>
            <option value="ing">처리중</option>
            <option value="end">처리완료</option>
          </select>
          <!-- <div id="search-memberType" class="search-type">
            <form action="/mvc/admin/memberFinder">
              <input type="hidden" name="searchType" value="memberType">
              <input type="radio" name="searchKeyword" value="U" class="radio-btn">접수
              <input type="radio" name="searchKeyword" value="I" class="radio-btn">처리중
              <input type="radio" name="searchKeyword" value="E" class="radio-btn">처리완료
              <button type="submit" class="btn">검색</button>
            </form>
          </div> -->
        </div>
      </div>
      <table>
        <thead id="list-head">
          <tr>
            <th>날짜</th>
            <th>게시판</th>
            <th>제목</th>
            <th>처리상태</th>
          </tr>
        </thead>
        <tbody id="list-content">
          <tr>
            <td>2022-02-02</td>
            <td>오디션 후기</td>
            <td><a href="#">가나다라마바사아자차카타파하</a></td>
            <td>접수</td>
          </tr>
          <tr>
            <td>2022-04-20</td>
            <td>공고 게시판</td>
            <td><a href="#">abcdefghijklmnopqrstuvwxyz</a></td>
            <td>처리중</td>
          </tr>
          <tr>
            <td>2022-04-12</td>
            <td>공고 게시판</td>
            <td><a href="#">abcdefghijklmnopqrstuvwxyz</a></td>
            <td>처리완료</td>
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