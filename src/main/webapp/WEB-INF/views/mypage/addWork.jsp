<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <tbody id="addWork-tbody">
          <tr>
            <th><label for="pic">대표사진</label></th>
            <td>
              <div id="work-img-container">
			     <img src="" alt="" id="work-img"/>
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
          	<td>
          		<input type="hidden" name="member" value="actor"/>
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
  		
  		// 비동기요청 파일업로드 FormData 객체 사용
  		const frmData = new FormData(e.target);
  		console.log(frmData.values());

  		
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

  				const tbody = $(opener.document).querySelector("#addWork-tbody");
  				console(tbody);
  				
  				self.close();
  				
  				
  			},
  			error : console.log
  		});
  	});
  </script>
</body>
</html>