<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String memberId = (String) request.getAttribute("memberId");
	System.out.println("addWork.jsp@memberId = " + memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/addwork.css" />
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<title>Insert title here</title>
</head>
<body>
  <div id="container">
    <form name="addWorkFrm">
      <legend>경력 등록</legend>
      <table>
        <tbody>
          <tr>
            <th><label for="pic">대표사진</label></th>
            <td>
              <div id="work-img-container">
			     <img src="<%= request.getContextPath() %>/images/defaultImg.jpg" alt="" id="work-img" alt=""/>
		      </div>
              <input type="file" name="workpic" id="workpic" accept="image/*" onchange="loadImage(this);">
            </td>
          </tr>
          <tr>
            <th><label for="title">작품명</label></th> 
            <td><input type="text" name="title" id="title"></td>
          </tr>
          <tr>
            <th><label for="myrole">배역</label></th>
            <td><input type="text" name="role" id="role"></td>
          </tr>
          <tr>
            <th><label for="period">기간</label></th>
            <td><input type="text" name="period" id="period"></td>
          </tr>
          <tr>
            <th><label for="videolink">참고링크</label></th>
            <td><textarea name="videolink" id="videolink" cols="35" rows="5"></textarea></td>
            <!-- <td><input type="text" name="video" id="video"></td> -->
          </tr>
                    <tr>
            <th><label for="pic">첨부사진2</label></th>
            <td>
              <input type="file" name="pic2" id="pic2">
            </td>
          </tr>
          <tr>
            <th><label for="pic">첨부사진3</label></th>
            <td>
              <input type="file" name="pic3" id="pic3">
            </td>
          </tr>
          <tr>
            <th><label for="pic">첨부사진4</label></th>
            <td>
              <input type="file" name="pic4" id="pic4">
            </td>
          </tr>
          
          <tr>
          	<td>
          		<input type="hidden" name="member" value="<%= memberId %>"/>
           		<button>저장</button>          	
          	</td>
          </tr>
        </tbody>
      </table>
    </form>
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
				
				const titleId = "workTitle" + work.no;
 				const castId = "workCast" + work.no;
 				const periodId = "workPeriod" + work.no;
 				const imgId = "workImg" + work.no;
 				
  				const trs = `
  				<tbody id="\${tbodyId}">
  		          <tr>
  		            <th rowspan="5" class="work-no">
  		            	<input type="checkbox" name="ck" value="\${work.no}" class="ckbox" />
  		            </th>
  		            <td rowspan="5">
  		              <div id="work-img-container">
  		                <img src="\${img_src}" id="\${imgId}" class="work-img" value="\${work.no}" onclick="editWork(this);">
  		              </div>
  		            </td>
  		            <td><br><br></td>
  		          </tr>
  		          <tr class="work-tr">
  		            <th>작품명</th>
  		            <td colspan="3" id="\${titleId}">\${work.title}</td>
  		          </tr>
  		          <tr class="work-tr">
  		            <th>배역</th>
  		            <td colspan="3" id="\${castId}">\${work.myrole}</td>
  		          </tr>
  		          <tr class="work-tr">
  		            <th>기간</th>
  		            <td colspan="3" id="\${periodId}">\${work.period}</td>
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