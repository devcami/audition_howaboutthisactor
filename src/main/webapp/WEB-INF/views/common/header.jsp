<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = "admin";
	String memberRole = "A";
	
	// String memberId = "director";
	// String memberRole = "D";
	
	String url = "";
	switch(memberRole){
	case("A"):	
		url = "/mypage/memberList";
		break;
	case("D"):
		url = "/mypage/myAnn?memberId=" + memberId + "&memberRole=" + memberRole;
		break;
	case("P"):
		url = "/mypage/portfolio?memberId=" + memberId + "&memberRole=" + memberRole;
		break;
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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
   	<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
</head>
<body>
    <div class="nav">
        <div class="nav-main">
            <a href="<%= request.getContextPath() %>" />배우어때</a>
        </div>
        <div class="nav-right-items">
            <div class="nav-item"><a href="<%= request.getContextPath() %>/actor/actorSearch">배우찾기</a></div>
            <div class="nav-item"><a href="<%= request.getContextPath() %>/ann/annList">공고찾기</a></div>
            <div class="nav-item"><a href="actorboard.html">게시판</a></div>
            <div class="nav-item"><a href="<%= request.getContextPath() %><%= url %>">마이페이지</a></div>
            <div class="nav-item"><a href="<%= request.getContextPath() %>/member/memberLogin">로그인</a></div>
            <div class="nav-item"><a href="<%= request.getContextPath() %>/member/memberEnroll">회원가입</a></div>
        </div>
    </div>