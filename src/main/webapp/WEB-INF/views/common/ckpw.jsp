 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
  <div id="pwck-container">
    <h2>비밀번호 확인</h2>
    <p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다. 비밀번호는 다른사람에게 노출되지 않도록 주의해주시기 바랍니다.</p>
    <div id="idpwbtn">
      <div id="idpw">
        <div class="box">
          <label for="id">아이디</label>
          <input type="text" name="member_id" id="member_id">
        </div>
        <div class="box">
          <label for="pw">비밀번호</label>
          <input type="password" name="pw" id="pw">
        </div>
      </div>
      <div id="btn-box">
        <button class="btn">확인</button>
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