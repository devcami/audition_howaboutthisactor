<%-- 로그인 성공여부 팝업창 '로그인 되었습니다.' '로그인에 실패하였습니다.' --%>
<%@page import="member.model.dto.Member"%>	
<%@page import="member.model.dto.Production" %>
<%@page import="member.model.dto.MemberRole"%>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/mLogin.css" />
<%


//	String msg = (String) session.getAttribute("msg");
//	if(msg != null)
//		session.removeAttribute("msg");

String saveId = null; // 아이디저장을 체크한 경우, memberId값이 담길 변수
Cookie[] cookies = request.getCookies();
if(cookies != null){
	for(Cookie cookie : cookies){
		if("saveId".equals(cookie.getName())){
			saveId = cookie.getValue();
		}
	}
}
else {
}
%>

<%-- 유효성 검사 --%>
<script> 
function.btnClick() => {
<% if(msg != null){ %>
	alert("<%= msg %>");
<% } %>
	
	
<% if(loginMember == null) { %>
	document.loginFrm.onsubmit = (e) => {
		const memberIdVal = memberId.value;
		const passwordVal = password.value;
		
		if(!/^.{4,}$/.test(memberIdVal)){
			alert("유효한 아이디를 입력해주세요.");
			memberId.select();
			return false;
		}
		if(!/^.{4,}$/.test(passwordVal)){
			alert("유효한 비밀번호를 입력해주세요.");
			password.select();
			return false;
		}
	};	
<% } %>
};


</script>

<section id=login-container>
	<% if(loginMember == null){ %>
	<div id="login-header">
   		<span>로그인</span>
    </div>
	<form name="memberLoginFrm" method="POST" id="member-login-form">
		<table class="table table-borderless">
			<tr>
				<th>
					아이디
				</th>
				<td>
					<input type="text" placeholder="아이디를 입력해주세요." name="memberId" id="_memberId" value="<%= saveId != null ? saveId : "" %>">
				</td>
			</tr>
			<tr>
				<th>
					비밀번호
				</th>
				<td>
					<input type="password" placeholder="비밀번호를 입력해주세요." name="password" id="_password"><br>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" name="saveId" class="saveId" id="saveId" <%= saveId != null ? "checked" : "" %>/>
					<label for="saveId" class="saveId">아이디저장</label>
					<input type="submit" id="btn-login" class="btn btn-primary" value="Login" onClick='btnClick()'>
				</td>
			</tr>
		</table>
	<div id="SNSLogin">
		<%--<a href="${url}"></a> 네이버 로그인 페이지 이동 --%>
		<img id="naver" src="${pageContext.request.contextPath}/images/naverLogin.png">
		
	  <a id="naverIdLogin_loginButton" href="javascript:void(0)">
          <span>네이버 로그인</span>
      </a>
		
		<%--<a href="${url}"></a> 카카오 로그인 페이지 이동 --%>
		<img id="kakao" src="${pageContext.request.contextPath}/images/kakaoLogin.png">
	</div>
	
	<div id="btn-group" class="btn-group" role="group" aria-label="Basic example">
	  <button type="button" class="btn f-btn b-line" onclick="location.href='<%= request.getContextPath() %>/member/memberEnroll';">회원가입</button>
	  <button type="button" class="btn f-btn b-line" id="id_find" onclick="findId();">아이디 찾기</button>
	  <button type="button" class="btn f-btn" id="pwd_find" onclick="findPw();">비밀번호 찾기</button>
	</div>
				
	<% } else { %>
		<%-- 로그인 성공시 --%>
<%-- 		<script type="text/javascript">
		// 뒤로 갈 히스토리가 있는 경우 및 우리 시스템에서 링크를 통해 유입된 경우
		if (document.referrer && document.referrer.indexOf("<%= request.getContextPath() %>") !== -1) {
		    history.back();    // 뒤로가기
		}
		// 히스토리가 없는 경우 (URL을 직접 입력하여 유입된 경우)
		else {
		    location.href = "<%= request.getContextPath() %>/";    // 메인페이지로 
		}
		</script> --%>
 		<table id="loginSuccess" onClick = "callback()">
			<tbody>
				<tr>
					<td><%= loginMember.getMemberName() %>님, 안녕하세요.</td><br>
				</tr>
				<tr>
				<td>
					<input type="button" value="로그아웃" onclick="location.href='<%= request.getContextPath() %>/member/logout';"/>							
				</td>
				</tr>
			</tbody>
		</table>
	<% } %>
	
	</form>
</section>


<form name="findIdFrm" action="<%= request.getContextPath() %>/member/findId">
	<input type="hidden" name="memberId" />
</form>
<script>
const findId = () => {
	const title = "findIdPopup";
	const spec = "width=500px, height=350px";
	const popup = open("", title, spec);
	
	const frm = document.findIdFrm;
	frm.target = title; // 해당팝업에서 폼을 제출!
	frm.submit();
};
</script>	

<form name="findPwFrm" action="<%= request.getContextPath() %>/member/findPw">
	<input type="hidden" name="password" />
</form>
<script>
const findPw = () => {
	const title = "findPwPopup";
	const spec = "width=500px, height=350px";
	const popup = open("", title, spec);
	
	const frm = document.findPwFrm;
	frm.target = title; // 해당팝업에서 폼을 제출!
	frm.submit();
};
</script>	

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>

// 토근 삭제는 일단 브라우저에서 하자...(추후 로그아웃 가능)


var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "STWpWhi2HZaIbtQUjBBh", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
			callbackUrl: "http://localhost:9090/app/member/memberLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
			isPopup: false,
			callbackHandle: true
			
			
		}
	);	

naverLogin.init();

var naver_id_login = new naver_id_login("STWpWhi2HZaIbtQUjBBh", "http://localhost:9090/app/member/memberLogin");
// 접근 토큰 값 출력
alert(naver_id_login.oauthParams.access_token);
// 네이버 사용자 프로필 조회
naver_id_login.get_naver_userprofile("naverSignInCallback()");
// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
function naverSignInCallback() {
  alert(naver_id_login.getProfileData('email'));
  alert(naver_id_login.getProfileData('nickname'));
  alert(naver_id_login.getProfileData('age'));
  </script>
  
  
 <script>
 <%--
window.addEventListener('load', function ()) {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		
			console.log(naverLogin.user); 
    		
            if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
};
--%>
</script>



<script>
<%--
	function setLoginStatus(){
		    
		      const message_area=document.getElementById('message');
		      message_area.innerHTML=`
		      <h3> Login 성공 </h3>
		      <div>user Nickname : ${naverLogin.user.nickname}</div>
		      <div>user Age(범위) : ${naverLogin.user.age}</div>
		      <div>user Birthday : ${naverLogin.user.birthday}</div>
		      `;
		     
		      const button_area=document.getElementById('button_area');
		      button_area.innerHTML="<button id='btn_logout'>로그아웃</button>";

		      const logout=document.getElementById('btn_logout');
		      logout.addEventListener('click',(e)=>{
		        naverLogin.logout();
			location.replace("http://127.0.0.1:5500");
		      })
		    }
	--%>
	</script>
	

<script>
<%--
String clientId = "STWpWhi2HZaIbtQUjBBh";//애플리케이션 클라이언트 아이디값";
String redirectURI = URLEncoder.encode("http://localhost:9090/app/member/memberLogin", "UTF-8");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString();
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
apiURL += "&client_id=" + clientId;
apiURL += "&redirect_uri=" + redirectURI;
apiURL += "&state=" + state;
session.setAttribute("state", state);
--%>
</script>

<script>

<%-- String clientId = "YOUR_CLIENT_ID";//애플리케이션 클라이언트 아이디값";
String clientSecret = "YOUR_CLIENT_SECRET";//애플리케이션 클라이언트 시크릿값";
String code = request.getParameter("code");
String state = request.getParameter("state");
String redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL", "UTF-8");
String apiURL;
apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
apiURL += "client_id=" + clientId;
apiURL += "&client_secret=" + clientSecret;
apiURL += "&redirect_uri=" + redirectURI;
apiURL += "&code=" + code;
apiURL += "&state=" + state;
String access_token = "";
String refresh_token = "";
System.out.println("apiURL="+apiURL);
try {
  URL url = new URL(apiURL);
  HttpURLConnection con = (HttpURLConnection)url.openConnection();
  con.setRequestMethod("GET");
  int responseCode = con.getResponseCode();
  BufferedReader br;
  System.out.print("responseCode="+responseCode);
  if(responseCode==200) { // 정상 호출
    br = new BufferedReader(new InputStreamReader(con.getInputStream()));
  } else {  // 에러 발생
    br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
  }
  String inputLine;
  StringBuffer res = new StringBuffer();
  while ((inputLine = br.readLine()) != null) {
    res.append(inputLine);
  }
  br.close();
  if(responseCode==200) {
    out.println(res.toString());
  }
} catch (Exception e) {
  System.out.println(e);
}  --%>

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>