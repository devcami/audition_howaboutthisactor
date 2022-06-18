<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String workNo = (String) request.getAttribute("workNo");
	System.out.println("viewWork.jsp@workNo = " + workNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/viewWork.css" />
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
  <link href="css/viewWork.css" rel="stylesheet" type ="text/css">
  <script src="https://kit.fontawesome.com/1c396dc14f.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body style="background-color: #f4ede5;">
  <div id="container">
    <nav id="navbar">
      <button id="btn1">수정</button>
      <button id="btn2">삭제</button>
    </nav>
    <div id="first-page" class="page">
      <div id="first-div">
        <div id="text-wrap">
          <h2>마우스피스</h2>
          <div id="video-btn-div">
            <a href="https://youtu.be/gRnuFC4Ualw" id="video-a">
              <span id="video-icon"><i class="fa-regular fa-circle-play"></i></span>
              Play video
            </a>
          </div>
          <div id="cast-date">
            <ul>
              <li class="border-right">
                <span class="icon" id="cast-icon"><i class="fa-solid fa-user"></i></span>
                <h5>호시 역</h5>
              </li>
              <li>
                <span class="icon" id="date-icon"><i class="fa-solid fa-calendar"></i></span>
                <h5>2022.09 ~ 2022.10</h5>
              </li>
            </ul>
          </div>
        </div>
        <div id="carouselExampleIndicators" class="carousel slide img-container" data-bs-ride="carousel">
          <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
          </div>
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="<%= request.getContextPath() %>/images/hosi/hosi11.jpg" class="d-block w-100 work-img">
            </div>
            <div class="carousel-item">
              <img src="<%= request.getContextPath() %>/images/hosi/hosi12.jpg" class="d-block w-100 work-img">
            </div>
            <div class="carousel-item">
              <img src="<%= request.getContextPath() %>/images/hosi/hosi13.jpg" class="d-block w-100 work-img">
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
    <div id="second-page" class="page">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/gRnuFC4Ualw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
  </div>
  <script>
  	const loadImage = (input) => {
  		console.log(input.files);
  		if(input.files[0]){
  			const fr = new FileReader();
  			fr.readAsDataURL(input.files[0]);
  			fr.onload = (e) => {
  				document.querySelector("#work-img").src = e.target.result
  			}
  		}
  	}
	
  	
  	document.addWorkFrm.addEventListener('submit', (e) => {
  		e.preventDefault();
  		
  		// 비동기요청 파일업로드 FormData 객체 사용
  		const frmData = new FormData(e.target);

  		const ptable = opener.document.getElementById("portTable"); 		
 
  		
  		$.ajax({
  			url : "<%= request.getContextPath() %>/mypage/enrollwork",
  			method : "POST",
  			dataType: "json",
  			data : frmData,
  			processData : false,
  			contentType : false,
  			success(work) {
  				console.log("work = ", work);
  				alert('등록이 완료되었습니다.');

  				const img_src = `<%= request.getContextPath() %>/upload/portfolio/\${work.attachment.renamedFilename}`;
				const tbodyId = "work" + work.no;
					
  				const trs = `
  				<tbody id="\${tbodyId}">
  		          <tr>
  		            <th rowspan="5" class="work-no">
  		            	<input type="checkbox" name="ck" value="\${work.no}" class="ckbox" />
  		            </th>
  		            <td rowspan="5">
  		              <div id="work-img-container">
  		                <img src="\${img_src}" class="work-img">
  		              </div>
  		            </td>
  		            <td><br><br></td>
  		          </tr>
  		          <tr class="work-tr">
  		            <th>작품명</th>
  		            <td colspan="3">\${work.title}</td>
  		          </tr>
  		          <tr class="work-tr">
  		            <th>배역</th>
  		            <td colspan="3">\${work.myrole}</td>
  		          </tr>
  		          <tr class="work-tr">
  		            <th>기간</th>
  		            <td colspan="3">\${work.period}</td>
  		          </tr>
  		          <tr>
  		            <td><br><br></td>
  		          </tr>
  		         <tbody>
  				`;
  				
  				ptable.insertAdjacentHTML('beforeend', trs);
  				
  				self.close();
  				
  			},
  			error : console.log
  		});
  	});
  </script>
</body>
</html>