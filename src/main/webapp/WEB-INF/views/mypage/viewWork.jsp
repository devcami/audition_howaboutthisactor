<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String workNo = (String) request.getAttribute("workNo");
	System.out.println("viewWork.jsp@workNo = " + workNo);
	String memberId = (String) request.getAttribute("memberId");
	System.out.println("viewWork.jsp@memberId = " + memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/viewWork.css" />
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<!-- <link href="css/viewWork.css" rel="stylesheet" type ="text/css"> -->
<script src="https://kit.fontawesome.com/1c396dc14f.js" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body style="background-color: #f4ede5;">
  <div id="container">
    <div id="first-page" class="page">
      <div id="first-div">
        <div id="text-wrap">
          <h2 id="workTitle"></h2>
          <div id="video-btn-div">
            <a href="" id="video-a" target='_blank'>
              <span id="video-icon"><i class="fa-regular fa-circle-play"></i></span>
              Play video
            </a>
          </div>
          <div id="cast-date">
            <ul>
              <li class="border-right">
                <span class="icon" id="cast-icon"><i class="fa-solid fa-user"></i></span>
                <h5 id="workRole">호시 역</h5>
              </li>
              <li>
                <span class="icon" id="date-icon"><i class="fa-solid fa-calendar"></i></span>
                <h5 id="workPeriod">2022.09 ~ 2022.10</h5>
              </li>
            </ul>
          </div>
        </div>
		<div id="boss-img-container">
        	<img src="" class="work-img" id="bossImg">
        </div>
      </div>
    </div>
    <div>
      <h3 id="img-msg" style="display: none;">관련 사진</h3>
    </div>
    <div id="img-div" style="display: none;">
      <div class="img-container" id="img1-div" style="display: none;">
        <img src="" class="work-img" id="img1">
      </div>
      <div class="img-container" id="img2-div" style="display: none;">
        <img src="" class="work-img" id="img2">
      </div>
      <div class="img-container" id="img3-div" style="display: none;">
        <img src="" class="work-img" id="img3">
      </div>
    </div>
    <div id="second-page" class="page" style="display: none;">
      <div>
      	<h3 id="iframe-msg">관련 영상</h3>
      </div>
      <iframe id="iframeVideo" src="" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
  </div>
  <script>
  
  window.onload = () => {
	  
		console.log('되나여');
  		
		$.ajax({
  			url: "<%= request.getContextPath() %>/mypage/detailWork",
  			dataType: "json",
  			data : {
  				"workNo" : "<%= workNo %>",
  				"memberId" : "<%= memberId %>"
  			},
  			success(work){
  				console.log(work);
  				
  				// 텍스트추가
  				$('#workTitle').text(work.title);
  				$('#workRole').text(work.myrole);
  				$('#workPeriod').text(work.period);
  				
  				// 비디오링크 추가
  				$("#video-a").attr("href", work.videolink)
  				
  				// 이미지 추가
  				let imgSrc = `<%= request.getContextPath() %>/upload/portfolio/\${work.attachment.renamedFilename}`;			
  				document.getElementById('bossImg').src = imgSrc;
  				
				if(work.attach1 != null || work.attach2 != null || work.attach3 != null){
					$('#img-msg').css('display', '');		
					$('#img-div').css('display', '');		
					
				}
				if(work.attach1 != null){
					imgSrc = `<%= request.getContextPath() %>/upload/portfolio/\${work.attach1.renamedFilename}`;
					$('#img1-div').css('display', '');
					document.getElementById('img1').src = imgSrc;
				}
				if(work.attach2 != null){
					imgSrc = `<%= request.getContextPath() %>/upload/portfolio/\${work.attach2.renamedFilename}`;
					$('#img2-div').css('display', '');
					document.getElementById('img2').src = imgSrc;
				}
				if(work.attach3 != null){
					imgSrc = `<%= request.getContextPath() %>/upload/portfolio/\${work.attach3.renamedFilename}`;
					$('#img3-div').css('display', '');
					document.getElementById('img3').src = imgSrc;
				}
				
				// iframe 설정
				if(work.videolink != null) {
					$('#second-page').css('display', '');
					console.log(work.videolink);
					const arr = work.videolink.split("/");
					const videoSrc = "https://www.youtube.com/embed/" + arr[3];
					console.log(videoSrc);
					document.getElementById('iframeVideo').src = videoSrc;
				}
  				
  				
  			},
  			error : console.log
  			
  		});  		
  		
  	}
  </script>
  
</body>
</html>