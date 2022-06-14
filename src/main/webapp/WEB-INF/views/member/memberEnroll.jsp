<%-- '회원가입에 성공하였습니다.' 혹은 유효성 검사 확인 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/mEnroll.css" />
<section id=enroll-container>
	<form name="memberEnrollFrm" method="POST">
	<div id="Enroll_head">
      <h2>회원가입</h2>
    </div><br><br>
		<table>
			<tr>
				<th>ID<sup>*</sup></th>
				<td>
					<input type="text" placeholder="10글자이상" name="memberId" id="_memberId">
					<input type="button" value="ID 중복검사" onclick="checkIdDuplicate();" />
					<input type="hidden" id="idValid" value="0" />
					<%-- #idValid 0이면 중복검사전, 1이면 중복검사통과 --%>
				</td>
			</tr>
			<tr>
				<th>숫자, 영문자 포함</th>
			<tr>
				<th>비밀번호<sup>*</sup></th>
				<td>
					<input type="password" placeholder="6글자이상" name="password" id="_password"><br>
				</td>
			</tr>
			<tr>
				<th>숫자, 영문자, 특수기호 포함</th>
			<tr>
			<tr>
				<th>비밀번호 확인<sup>*</sup></th>
				<td>	
					<input type="password" id="passwordCheck"><br>
				</td>
			</tr>  
			<tr>
				<th>이름<sup>*</sup></th>
				<td>	
				<input type="text"  name="memberName" id="memberName"><br>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>	
				<input type="date" name="birthday" id="birthday"><br/>
				</td>
			</tr> 
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11"><br>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" placeholder="" name="address" id="address"><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<input type="radio" name="gender" id="gender0" value="M">
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F">
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>회원 유형 </th>
				<td>
					<input type="radio" name="type" id="type0" value="P">
					<label for="type0">배우 및 아티스트</label>
					<input type="radio" name="type" id="type1" value="D">
					<label for="type1">제작자 및 캐스팅 담당자</label>
				</td>
			</tr>
			<tr>
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
				<th>이메일</th>
				<td>	
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
					<input type="button" value="인증메일 받기" onclick="checkEmail();" />
				</td>
			</tr>
		</table>
		<br>
		<input type="submit" id="button1" value="가입" >
		<input type="reset" id="button2" value="취소">
	</form>
</section>
<form name="checkIdDuplicateFrm" action="<%= request.getContextPath() %>/member/checkIdDuplicate">
	<input type="hidden" name="memberId" />
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
};
=======
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
>>>>>>> branch 'master' of https://github.com/devcami/semi_Project.git

</body>
</html>