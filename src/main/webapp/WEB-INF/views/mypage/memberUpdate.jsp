<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberUpdate.css" />
<%

   
	List<ActorInfo> list = (List<ActorInfo>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
%>
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <% if(memberRole == "D"){ %> 
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/myAnn?memberId=<%= memberId %>?memberRole=<%= memberRole %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 조회</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/myboard" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseout="mouseout(this)">지원자 목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/companyInfo" onmouseover="mousein(this);" onmouseout="mouseout(this)">회사 정보</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=delete&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	    </ul>
	<% } else { %>
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/portfolio?memberId=<%= memberId %>"  onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/myboard" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseout="mouseout(this)">지원한 공고</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=delete&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	    </ul>
	<% } %>
  </div>
    <div id="update-info">
    <h2>회원정보 수정</h2>
    <form name="updateInfoFrm" method="post">
      <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-2 col-form-label">아이디</label>
        <div class="col-sm-10"  id="nameDiv">
          <input type="text" readonly class="form-control-plaintext" name="memberId" id="memberId" value="hosi">
        </div>
      </div>

      <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="inputPassword" placeholder="Email Address">
        </div>
      </div>

      <fieldset class="row mb-3">
        <legend class="col-form-label col-sm-2 pt-0">성별</legend>
        <div class="col-sm-10">
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="gender" id="female" value="F">
            <label class="form-check-label" for="inlineRadio1">여성</label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="gender" id="male" value="M">
            <label class="form-check-label" for="inlineRadio2">남성</label>
          </div>
        </div>
      </fieldset>

      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
        <div class="col-sm-10">
          <input type="password" class="form-control" id="pw" name="pw" placeholder="Password">
        </div>
      </div>
      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호 확인</label>
        <div class="col-sm-10">
          <input type="text" class="form-control is-invalid" id="pwck" name="pwck" aria-describedby="validationServer03Feedback" required>
          <div id="validationServer03Feedback" class="invalid-feedback">
          비밀번호가 일치하지 않습니다.
          </div>
        </div>
      </div>

      <fieldset class="row mb-3">
        <legend class="col-form-label col-sm-2 pt-0">회원 유형</legend>
        <div class="col-sm-10">
          <div class="form-check">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
            <label class="form-check-label" for="gridRadios1">
              배우 및 아티스트
            </label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
            <label class="form-check-label" for="gridRadios2">
              제작사 및 캐스팅 디렉터
            </label>
          </div>
        </div>
      </fieldset>

      <div class="mb-3 row">
        <label class="col-form-label col-sm-2 pt-0">관심지원분야</label>
        <div class="form-check form-check-inline genre-div movie-div">
          <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
          <label class="form-check-label" for="inlineCheckbox1">영화</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
          <label class="form-check-label" for="inlineCheckbox2">드라마</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
          <label class="form-check-label" for="inlineCheckbox2">뮤지컬</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
          <label class="form-check-label" for="inlineCheckbox2">연극</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option2">
          <label class="form-check-label" for="inlineCheckbox2">재연</label>
        </div>
      </div>

      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">휴대폰</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="phone" name="phone" placeholder="Phone">
        </div>
      </div>
      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">생년월일</label>
        <div class="col-sm-10">
          <input type="date" class="form-control" id="birth" name="birth">
        </div>
      </div>

      <br><br>
      <div class="btn-div">
        <button type="button" id="btn-first-enroll" class="btn-next">저장</button>
      </div>
    </form>
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
      // location.href=`/app/ann/annView?actorNo=\${actorNO}`;
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