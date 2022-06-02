<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   	
</head>
<body>
    <div class="nav">
        <div class="nav-main">
            <a href="index.html">배우어때</a>
        </div>
        <div class="nav-right-items">
            <div class="nav-item"><a href="actor.html">배우찾기</a></div>
            <div class="nav-item"><a href="<%= request.getContextPath() %>/ann/annList">공고찾기</a></div>
            <div class="nav-item"><a href="actorboard.html">게시판</a></div>
            <div class="nav-item"><a href="mypage.html">마이페이지</a></div>
            <div class="nav-item"><a href="actorjoin.html">로그인&회원가입</a></div>
        </div>
    </div>