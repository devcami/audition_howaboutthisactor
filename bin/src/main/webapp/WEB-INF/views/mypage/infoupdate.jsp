<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/infoupdate.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="#" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="update-info">
    <h2>회원정보 수정</h2>
    <form name="updateInfoFrm" method="post">
      <table>
        <tbody>
          <tr>
            <th>이름</th>
            <td><input type="text" name="memberName" id="memberName"><br></td>
          </tr>
          <tr>
            <th>생년월일</th>
            <td><input type="date" name="birthday" id="birthday"><br></td>
          </tr>
          <tr>
            <th>비밀번호</th>
            <td><input type="password" name="pw" id="pw"><br></td>
          </tr>
          <tr id="tr-pwck">
            <th id="pwckth">비밀번호 확인</th>
            <td><input type="password" name="pwck" id="pwck"><br>
              <span id="msg">비밀번호가 일치하지 않습니다</span></td>
          </tr>
          <!-- <tr id="msg">
            <th></th>
            <td></td>
          </tr> -->
          <tr>
            <th>회원유형</th>
            <td>
              <input type="radio" name="type" value="actor" id="type-actor">배우 및 아티스트
              <br>
              <input type="radio" name="type" value="director" id="type-director">제작사 및 캐스팅 담당자
            </td>
          </tr>
          <tr>
            <th>휴대폰</th>
            <td><input type="tel" name="phone" id="phone"><br></td>
          </tr>
          <tr>
            <th>이메일</th>
            <td><input type="email" name="email" id="email"><br></td>
          </tr>
        </tbody>
      </table>
      <div>
        <input type="submit" class="btn" value="정보수정">
      </div>
    </form>
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