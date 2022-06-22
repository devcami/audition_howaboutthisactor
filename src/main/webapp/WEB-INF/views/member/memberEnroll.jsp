<%-- '회원가입에 성공하였습니다.' 혹은 유효성 검사 확인 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.Date"%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@page import="ann.model.dto.Ann"%>	
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String memberId = (String) request.getAttribute("memberId");
	String email = (String) request.getAttribute("email");

%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/mEnroll.css" />
<section id=enroll-container>
	<form name="memberEnrollFrm" method="POST">
	<div id="Enroll_head">
      <h2>회원가입</h2>
    </div><br><br>
		<table>
			<tr>
				<th>ID<sup>*</sup></th>
			<% if(memberId != null){ %>
				<td>
					<input type="text" name="memberId" value="<%= memberId %>" readonly />
				</td>	
			<% } else {%>
				<td>
					<input type="text" placeholder="6글자이상" name="memberId" id="_memberId" required>
					<input type="button" value="ID 중복검사" onclick="checkIdDuplicate();"/>
					<input type="hidden" id="idValid" value="0" />
					<%-- #idValid 0이면 중복검사전, 1이면 중복검사통과 --%>
				</td>
			<% } %>
			</tr>
			<tr>
				<th></th>
					<td id="msg1">숫자, 영문자 포함 6글자 이상</td>
			</tr>
			<tr>
				<th>비밀번호<sup>*</sup></th>	
				<td>
					<input type="password" placeholder="6글자이상" name="password" id="_password" required><br>
				</td>
			</tr>
			<tr>
				<th></th>
					<td id="msg2">숫자, 영문자, 특수기호(!@#$%^&*()) 포함</td>
			</tr>
			<tr>
				<th>비밀번호 확인<sup>*</sup></th>
				<td>	
					<input type="password" id="passwordCheck" required><br>
				</td>
			</tr>  
			<tr>
				<th>이름<sup>*</sup></th>
				<td>	
				<input type="text"  name="memberName" id="memberName" required><br>
				</td>
			</tr>
			<tr>
				<th></th>
					<td id="msg1">이름은 한글 2글자 이상 가능합니다.</td>
			</tr>
			<tr>
				<th>생년월일<sup>*</sup></th>
				<td>	
				<input type="date" name="birthday" id="birthday" required><br/>
				</td>
			</tr> 
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required><br>
				</td>
			</tr>
			<tr>
				<th>성별<sup>*</sup></th>
				<td>
					<input type="radio" name="gender" id="gender0" value="M" required>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F" required>
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr >
				<th>회원 유형<sup>*</sup></th>
				<td>
					<input type="radio" name="memberRole" id="memberRole0" value="P" required onClick="viewGenre()">
					<label for="type0">배우 및 아티스트</label>
					<input type="radio" name="memberRole" id="memberRole1" value="D" required onClick="hideGenre()">
					<label for="type1">제작자 및 캐스팅 담당자</label>
				</td>
			</tr>
			<tr id="genre">
				<th>관심지원분야</th>
				<td>
					<input type="checkbox" name="genre" id="genre0" value="영화"><label for="genre0">영화</label>
					<input type="checkbox" name="genre" id="genre1" value="드라마"><label for="genre1">드라마</label>
					<input type="checkbox" name="genre" id="genre2" value="뮤지컬"><label for="genre2">뮤지컬</label>
					<input type="checkbox" name="genre" id="genre3" value="연극"><label for="genre3">연극</label>
					<input type="checkbox" name="genre" id="genre4" value="재연"><label for="genre4">재연</label><br/>
				</td>
			</tr>
			<tr>
				<th>이메일<sup>*</sup></th>
			<% if(email != null) { %>
				<td>
					<input type="email" name="email" value="<%= email %>" readonly />
				</td>
			<% } else { %>
				<td>	
					<input type="email" placeholder="abc123@xyz.com" name="email" id="email" required>
					<input type="button" value="Email 중복검사" onclick="checkEmailDuplicate();" />
					<input type="hidden" id="emailValid" value="0" />
					<%-- #idValid 0이면 중복검사전, 1이면 중복검사통과 --%>
					<br>
					<%-- 가능하다면 아래처럼 구현하고픔... 
					<input type="email" placeholder="abc123" name="email" id="email">
					<b>@</b>
					<select name="email_back">
						<option value="">-- 선택 --</option>
						<option value="naver">naver.com</option>
						<option value="daum">daum.net</option>
						<option value="gmail">gmail.com</option>
						<option value="hanmail">hanmail.net</option>
						<option value="nate">nate.com</option>
						<option value="ms">microsoft.com</option>
						<option value="outlook">outlook.com</option>
					</select>
					--%>
				</td>
			<% } %>
			</tr>
		</table>
		<br>
		<div class="exform_txt"><span>표시는 필수적으로 입력해주셔야 가입이 가능합니다.</span></div>
		<br>
		    <div class="agree_wrap">
            <div class="checkbox_wrap">
              <input type="checkbox" id="news_letter" name="news_letter" class="agree_chk">
              <label for="news_letter">[선택]뉴스레터 수신동의</label>
            </div>
            <div class="checkbox_wrap mar27">
              <input type="checkbox" id="marketing" name="marketing" class="agree_chk">
              <label for="marketing">[선택]마케팅 목적 개인정보 수집 및 이용에 대한 동의</label>
              <ul class="explan_txt">
                <li><span class="red_txt">항목 : 성별, 생년월일</span></li>
                <li>고객님께서는 위의 개인정보 및 회원정보 수정 등을 통해 추가로 수집하는 개인정보에<br/>
                  대해 동의하지 않거나 개인정보를 기재하지 않음으로써 거부하실 수 있습니다.<br/>
                  다만 이때 회원 대상 서비스가 제한될 수 있습니다.
                </li>
              </ul>
            </div>
          </div>
          <br>
		<input type="submit" id="button1" value="가입">
		<input type="reset" id="button2" value="다시입력">
	</form>
</section>
<form name="checkIdDuplicateFrm" action="<%= request.getContextPath() %>/member/checkIdDuplicate">
	<input type="hidden" name="memberId" />
</form>
<form name="checkEmailDuplicateFrm" action="<%= request.getContextPath() %>/member/checkEmailDuplicate">
	<input type="hidden" name="email" />
</form>
<script>
const checkIdDuplicate = () => {
	
	const title = "checkIdDuplicatePopup";
	const spec = "width=300px, height=200px";
	const popup = open("", title, spec);
	
	const frm = document.checkIdDuplicateFrm;
	
	frm.target = title; // 해당팝업에서 폼을 제출!
	
	frm.memberId.value = _memberId.value;
	frm.submit();
	
	<%--
 	if (frm.memberId.value.length < 1) {
		  alert("아이디를 입력하고 눌러주세요.");
		  
	}
	--%>

};

passwordCheck.onblur = () => {
	if(_password.value !== passwordCheck.value){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}	
	return true;
};

const checkEmailDuplicate = () => {
const title = "checkEmailDuplicatePopup";
const spec = "width=300px, height=200px";
const popup = open("", title, spec);

const frm = document.checkEmailDuplicateFrm;
frm.target = title; // 해당팝업에서 폼을 제출!
frm.email.value = email.value;
frm.submit();
};

const hideGenre = () => {
	  const row = document.getElementById('genre');
	  row.style.display = 'none';
}

const viewGenre = () => {
	  const row = document.getElementById('genre');
	  row.style.display = '';
}

// 유효성 검사
document.memberEnrollFrm.onsubmit = () => {
	// memberId 영문자/숫자 6글자 이상
	if(!/^[A-Za-z0-9]{6,}$/.test(_memberId.value)){
		alert("아이디는 영문자/숫자로 6글자 이상이어야 합니다.");
		idValid=0;
		return false;
	}  
	// 중복검사여부 체크
	if(idValid.value !== "1") {
		alert("아이디 중복검사 해주세요." + idValid);
		
		return false;
	}
	// password 영문자/숫자/특수문자!@#$%^&*()
	if(!/^[A-Za-z0-9!@#$%^&*()]{6,}$/.test(_password.value)){
		alert("비밀번호는 영문자/숫자/특수문자!@#$%^&*()로 6글자 이상이어야 합니다.");
		
		return false;
	}
	if(!passwordCheck.onblur()){
		return false;		
	}
	
	// memberName
	if(!/^[가-힣]{2,}$/.test(memberName.value)){
		alert("이름은 한글 2글자이상 입력해주세요.");
		return false;
	}
	
	// phone
	if(!/^010\d{8}$/.test(phone.value)){
		alert("유효한 전화번호를 입력하세요.");
		return false;
	}
	
	// 이메일 중복검사여부 체크
	if(emailValid.value !== "1") {
		alert("이메일 중복검사 해주세요.");
		return false;
	}

};


</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
