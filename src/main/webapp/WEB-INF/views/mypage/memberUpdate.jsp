<%@page import="java.util.Arrays"%>
<%@page import="java.sql.Date"%>
<%@page import="mypage.model.dto.ActorInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/memberUpdate.css" />
<%
	// String result = (String) session.getAttribute("result");

	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
	Date birthday = loginMember.getBirthday(); // null값이어도 input:datetime에서 무시함.
	String email = loginMember.getEmail() != null ? loginMember.getEmail() : "";
	String phone = loginMember.getPhone();
	String gender = loginMember.getGender() != null ? loginMember.getGender() : "";
	String hobby = loginMember.getGenre(); // 등산,게임
	String type = loginMember.getMemberRole().toString();
	
	List<String> genreList = null;
	if(hobby != null){
		String[] arr = hobby.split(",");
		genreList = Arrays.asList(arr); // String[] -> List<String>
	}


%>
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <% if( loginMember.getMemberRole().toString().equals("D")){ %> 
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 조회</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/myboard?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applicantList" onmouseout="mouseout(this)">지원자 목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/companyInfo?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">회사 정보</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=delete&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	    </ul>
	<% } else { %>
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/portfolio"  onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applylist?memberId=<%= loginMember.getMemberId() %>" onmouseout="mouseout(this)">지원한 공고</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=delete&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	    </ul>
	<% } %>
  </div>
    <div id="update-info">
    <h2>회원정보 수정</h2>
    <form 
    	name="memberUpdateFrm" 
    	method="post"
    	action="<%= request.getContextPath() %>/mypage/updateMemberInfo"">
      <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-2 col-form-label">아이디</label>
        <div class="col-sm-10"  id="nameDiv">
          <input type="text" readonly class="form-control-plaintext" name="memberId" id="memberId" value="<%= memberId %>">
        </div>
      </div>
      
       <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-2 col-form-label">이름
        	<span class="need">*</span>
        </label>
        <div class="col-sm-10">
          <input 
          	type="text" class="form-control" 
          	name="memberName" id="memberName" 
          	placeholder="Name" value="<%= memberName %>" required>
        </div>
      </div>

      <div class="mb-3 row">
        <label for="staticEmail" class="col-sm-2 col-form-label">Email
        	<span class="need">*</span>
        </label>
        <div class="col-sm-10">
          <input 
          	type="text" class="form-control" 
          	name="memberEmail" id="memberEmail" 
          	placeholder="Email Address" value="<%= email %>" required>
        </div>
      </div>

      <fieldset class="row mb-3">
        <legend class="col-form-label col-sm-2 pt-0">
        	성별<span class="need">*</span>
        </legend>
        <div class="col-sm-10">
          <div class="form-check form-check-inline">
            <input 
            	class="form-check-input" type="radio" name="gender" id="female" value="F"
            	<%="F".equals(gender) ? "checked" : ""%>>
            <label class="form-check-label" for="inlineRadio1">여성</label>
          </div>
          <div class="form-check form-check-inline">
            <input 
            	class="form-check-input" type="radio" name="gender" id="male" value="M"
            	<%="M".equals(gender) ? "checked" : ""%>>
            <label class="form-check-label" for="inlineRadio2">남성</label>
          </div>
        </div>
      </fieldset>
      
      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">
        	비밀번호<span class="need">*</span>
        </label>
        <div class="col-sm-10">
          <input 
          	type="password" class="form-control" 
          	aria-describedby="validationServer03Feedback" required
          	id="pw" name="pw" placeholder="Password">
          <div id="validationServer03Feedback" id="pw-msg"class="invalid-feedback">
      	    비밀번호는 영문자/숫자/특수문자!@#$%^&*()로 6글자 이상이어야 합니다.
          </div>
        </div>
      </div>
      
      
      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">
        	비밀번호 확인<span class="need">*</span>	
        </label>
        <div class="col-sm-10">
          <input 
          	type="password" class="form-control"
          	id="pwck" name="pwck" placeholder="Password Check" 
          	aria-describedby="validationServer03Feedback" 
          	required>
          <div id="validationServer03Feedback" id="pwck-msg" class="invalid-feedback">
          비밀번호가 일치하지 않습니다.
          </div>
        </div>
      </div>

      <fieldset class="row mb-3">
        <legend class="col-form-label col-sm-2 pt-0">
        	회원 유형<span class="need">*</span>
        </legend>
        <div class="col-sm-10">
          <div class="form-check">
            <input class="form-check-input" type="radio" name="type" id="P" value="P" 
            		onclick="return(false);" <%="P".equals(type) ? "checked" : ""%>>
            <label class="form-check-label" for="gridRadios1">
              배우 및 아티스트
            </label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="type" id="D" value="D" 
            		onclick="return(false);" <%="D".equals(type) ? "checked" : ""%>>
            <label class="form-check-label" for="gridRadios2">
              제작사 및 캐스팅 디렉터
            </label>
          </div>
        </div>
      </fieldset>

	<%
		if(loginMember.getMemberRole().toString().equals("P")){
	%>
	  <div class="mb-3 row" id="genre-div">
        <label class="col-form-label col-sm-2 pt-0">관심지원분야</label>
        <div class="form-check form-check-inline genre-div movie-div">
          <input class="form-check-input" name="genre" type="checkbox" id="movie" value="영화"
          <%= genreList != null && genreList.contains("영화") ? "checked" : "" %>>
          <label class="form-check-label" for="inlineCheckbox1">영화</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" name="genre" type="checkbox" id="drama" value="드라마"
          <%= genreList != null && genreList.contains("드라마") ? "checked" : "" %>>
          <label class="form-check-label" for="inlineCheckbox2">드라마</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" name="genre" type="checkbox" id="musical" value="뮤지컬"
          <%= genreList != null && genreList.contains("뮤지컬") ? "checked" : "" %>>
          <label class="form-check-label" for="inlineCheckbox2">뮤지컬</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" name="genre" type="checkbox" id="play" value="연극"
          <%= genreList != null && genreList.contains("연극") ? "checked" : "" %>>
          <label class="form-check-label" for="inlineCheckbox2">연극</label>
        </div>
        <div class="form-check form-check-inline genre-div">
          <input class="form-check-input" name="genre" type="checkbox" id="inlineCheckbox2" value="재연"
          <%= genreList != null && genreList.contains("재연") ? "checked" : "" %>>
          <label class="form-check-label" for="inlineCheckbox2">재연</label>
        </div>
      </div>
	<% 		
		}
	%>

      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">
        	휴대폰<span class="need">*</span>
        </label>
        <div class="col-sm-10">
          <input 
          	type="text" class="form-control" id="phone" name="phone" placeholder="Phone" required
          	value="<%= phone %>">
        </div>
      </div>
      <div class="mb-3 row">
        <label for="inputPassword" class="col-sm-2 col-form-label">
        	생년월일<span class="need">*</span>
        </label>
        <div class="col-sm-10">
          <input type="date" class="form-control" id="birth" name="birth" required value="<%= birthday %>">
        </div>
      </div>
      <br><br>
      <div class="btn-div">
        <button 
        	type="submit" 
        	id="btn-first-enroll" 
        	class="btn-next">저장</button>
      </div>
    </form>
  </div>
  
  <script>
  	window.onload = () => {
  	}
  
  	$('#pw-msg').addClass('hide');
  	$('#pwck-msg').addClass('hide');
  	$('#pwck').removeClass('is-invalid');
  
  	const hide = (box) => {
  		$(box).removeClass('is-invalid');
  	}
  	
  	const error = (box) => {
  		$(box).addClass('is-invalid');
  	}
  	const pass = (box) => {
  		$(box).addClass('is-valid');
  	}
  	const removeAll = (box) => {
  		$(box).removeClass('is-valid');
  		$(box).removeClass('is-invalid');
  	}
  	
  	
  	$('#pw').keyup(() => {
  		const box = '#pw';
  		const pwVal = $('#pw').val();
  		console.log(pwVal);
  		
  		if(!/^[A-Za-z0-9!@#$%^&*()]{4,}$/.test(pwVal)){
			error(box);
  			return false;
  		}
  		
  		hide(box);
  		pass(box);
  	});
  	
  	$('#pw').blur(() => {
    	  if($('#pw').val().length == 0){
			removeAll('#pw');
    	  }
    });
  	
  	$('#pwck').keyup(() => {
  	  const pwck = $('#pwck').val();
  	  const pwVal = $('#pw').val();
  	  
  	  
  	  // console.log(ckpw.length)
  	  if(pwck.length == 0){
  		$('#pwck-msg').addClass('hide');
  		$('#pwck').addClass('is-invalid');
  	  }
  	  if(pwck == pwVal){
  		$('#pwck').removeClass('is-invalid');
  		$('#pwck').addClass('is-valid');
  		$('#pwck-msg').addClass('hide');
  	  }
  	  else {
  		 $('#pwck-msg').removeClass('hide');
  		 $('#pwck').addClass('is-invalid');
  	  }
  	});
  	
  	$('#pwck').blur(() => {
  	  if($('#pwck').val().length == 0){
  	    removeAll('#pwck');
  	  }
  	});

  	
    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=type]").change(function(){
 
        if($("input[name=type]:checked").val() == "P"){
        	$("#genre-div").removeClass('hide');
 
        }else {
        	$("#genre-div").addClass('hide');
        }
    });
  	
    document.memberUpdateFrm.onsubmit = () => {
    	
  		// password 영문자/숫자/특수문자!@#$%^&*()
  		if(!/^[A-Za-z0-9!@#$%^&*()]{4,}$/.test(pw.value)){
  			alert("비밀번호는 영문자/숫자/특수문자!@#$%^&*()로 4글자 이상이어야 합니다.");
  			return false;
  		}
  		
  		// memberName
  		if(!/^[가-힣]{2,}$/.test(memberName.value)){
  			alert("이름은 한글 2글자이상 입력해주세요.");
  			return false;
  		}
  		
  		if(!/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/.test(memberEmail.value)){
  			alert("올바른 형식의 이메일을 입력해주세요.");
  			return false;
  		}
  		
  		// phone
  		if(!/^010\d{8}$/.test(phone.value)){
  			alert("유효한 전화번호를 입력하세요.");
  			return false;
  		}
    	
    }
    
  
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