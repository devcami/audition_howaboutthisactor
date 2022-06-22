<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.model.dto.MemberRole"%>
<%@page import="member.model.dto.Member"%>
<%
   //String memberId = "admin";
   //String memberRole = "A";
   
   // String memberId = "director";
   // String memberRole = "D";
   
   Member loginMember = (Member)session.getAttribute("loginMember");
   String msg = (String) session.getAttribute("msg");   
   if(msg != null){
      session.removeAttribute("msg");
   }
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>배우어때</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/semi.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('ce88338f9fbc3bc4ed27f1e8bf1b1752'); 
window.addEventListener('load', () => {
<% if(msg != null) { %>
   alert("<%= msg %>");
<% } %>
});
</script>
</head>
<body>
    <div class="nav">
        <div class="nav-main nav-item">
            <a class="ahover" href="<%= request.getContextPath() %>">배우어때</a>
        </div>
        <div class="nav-right-items">
            <div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %>/actor/actorList">배우찾기</a></div>
            <div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %>/ann/annListAsync">공고찾기</a></div>
            <div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %>/board/boardList">게시판</a></div>

             <% 
                String url = "";
                if(loginMember != null) {
                   
                   MemberRole memberRole = loginMember.getMemberRole();
                   
                   switch(memberRole.toString()){
                   case("A"):   
                      url = "/mypage/memberList";
                      break;
                   case("D"):
                      url = "/mypage/myAnn";
                      break;
                   case("P"):
                      url = "/mypage/portfolio";
                      break;
                   }
             %>
             	<div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %><%= url %>">마이페이지</a></div>  
	             <% 
	             	String memberId = loginMember.getMemberId();
	             	if(memberId.length() > 5 && memberId.substring(memberId.length()-5, memberId.length()).equals("Kakao")) { %>
	            	<div class="nav-item"><a class="ahover" onclick="kakaoLogout();">로그아웃</a></div>
	             <% } else { %>
            	<div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %>/member/logout">로그아웃</a></div>
				 <% } %>             
             <% } else { %>
               <div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %>/member/memberLogin">로그인</a></div>
               <div class="nav-item"><a class="ahover" href="<%= request.getContextPath() %>/member/memberEnroll">회원가입</a></div>           
             <% } %>        

        </div>
    </div>
    
<script>
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
        Kakao.API.request({
          url: '/v1/user/unlink',
          success: function (response) {
          	console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
        location.href = "<%= request.getContextPath() %>/member/logout";
        Kakao.Auth.setAccessToken(undefined)
      }
}
</script>