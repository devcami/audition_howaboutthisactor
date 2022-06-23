<%@page import="mypage.model.dto.PortAttachment"%>
<%@page import="java.util.List"%>
<%@page import="mypage.model.dto.PortfolioWork"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PortfolioWork work = (PortfolioWork) request.getAttribute("work");
	List<PortAttachment> attachs = (List<PortAttachment>) request.getAttribute("attachs");
	int portNo = (int) request.getAttribute("workNo");
	
	int workNo = work.getNo();
	String memberId = work.getMemberId();
	String title = work.getTitle();
	String myRole = work.getMyrole();
	String period = work.getPeriod();
	String videoLink = work.getVideolink();
	String bossPic = attachs.get(0).getRenamedFilename();
	int bossPicNo = attachs.get(0).getNo();
	
	System.out.println(memberId + title + myRole + period + videoLink);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/editWork.css" />
<link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<title>Insert title here</title>
</head>
<body>
  <div id="container">
    <form 
    	id="editWorkFrm"
    	name="editWorkFrm"
    	enctype="multipart/form-data">
      <legend>경력 수정</legend>
      <table>
        <tbody>
          <tr>
            <th><label for="pic">대표사진</label></th>
            <td>
              <div id="work-img-container">
			     <img src="<%= request.getContextPath() %>/upload/portfolio/<%= attachs.get(0).getRenamedFilename() %>" alt="" id="boss-img"/>
		      </div>
		      <input type="button" name="btn-delFile" class="del-btn" id="delFile0" value="삭제" onclick="fileDelete(this, <%= attachs.get(0).getNo() %>);"/>
              <input type="hidden" name="Obosspic" id="Obosspic" value="<%= bossPicNo %>" />
              <input type="file" name="workpic" id="workpic" accept="image/*" onchange="loadImage(this);" style="display: none;">
            </td>
          </tr>
          <tr>
            <th><label for="title">작품명</label></th>
            <td><input type="text" name="title" id="title" value="<%= title %>"></td>
          </tr>
          <tr>
            <th><label for="myrole">배역</label></th>
            <td><input type="text" name="role" id="role" value="<%= myRole %>"></td>
          </tr>
          <tr>
            <th><label for="period">기간</label></th>
            <td><input type="text" name="period" id="period" value="<%= period %>"></td>
            
          </tr>
          <tr>
            <th><label for="videolink">참고링크</label></th>
            <td><textarea name="videolink" id="videolink" cols="35" rows="5"><%= videoLink %></textarea></td>
            <!-- <td><input type="text" name="video" id="video"></td> -->
          </tr>
<%
		int i = 1;
		if(attachs != null && !attachs.isEmpty()){
			for(i = 1; i < attachs.size(); i++){
					PortAttachment pa = attachs.get(i);		
%>	
	          <tr>
	            <th><label for="pic">첨부사진<%= i %></label></th>
	            <td>
	              <div class="img-container" id="attachImg<%= i %>">
	  				<img src="<%= request.getContextPath() %>/upload/portfolio/<%= pa.getRenamedFilename() %>" class="work-img">
				  </div>
				  <input type="button" name="btn-delFile" class="del-btn" id="delFile<%= i %>" value="삭제" onclick="fileDelete(this, <%= pa.getNo() %>);"/>
				  <input type="file" name="pic<%= i %>" id="pic<%= i %>" style="display: none;">
	            </td>
	          </tr>
<%
			}
			System.out.println("i = " + i);
		}
		while(i <= 3){
%>
			<tr>
	          <th><label for="pic">첨부사진<%= i %></label></th>
	            <td>
				  <input type="file" name="pic<%= i %>" id="pic<%= i %>">
	            </td>
	          </tr>
			
<% 			
			i++;
		}
%>
          <tr>
          	<td>
			    <input type="hidden" name="workNo" value="<%= portNo %>" />
          		<input type="hidden" name="memberId" value="<%= memberId %>"/>
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
  				document.querySelector("#boss-img").src = e.target.result
  			}
  		}
  	}
  	
  	const fileDelete = (e, paNo) => {
  		console.log(e);
  		let fileNo = e.id.replace("delFile", "");
  		console.log('fileNo: ', fileNo);
  		if(confirm('첨부파일을 삭제하시겠습니까?')){
  			
  			if(fileNo == 0) {
  				// 프로필사진 이미지 소스 비우기
  				$('#boss-img').attr("src", ""); 
  				// 삭제하기 버튼 숨기고
  				$('#delFile0').css('display', 'none');
  				// 첨부하기 버튼(input) 추가
  				$('#workpic').css('display', '');
  				// $('#Obosspic').val
  			} 
  			else {
  	  			let fileId = "attachImg" + fileNo;
  	  			const delFile = document.getElementById(fileId);
  				// const inputFileId = "pic" + fileNo;
  				
  				console.log('delFile = ', delFile);
  				//console.log('inputFileId = ', inputFileId);
	  			delFile.style.display = "none"; 
	  			$(`#pic\${fileNo}`).css('display', '');
	  			
  			}
	  			let input = document.createElement('input');
  				input.setAttribute('type', 'hidden');
  				input.setAttribute('name', 'delFile');
  				input.setAttribute('value', paNo);
  				e.after(input);
  				e.style.display = "none";
  			
 // 			document.querySelectorAll("input[type=file]").forEach((attach)=>{
 // 				console.log(attach);
 //  				attach.id = "attach" + fileNo;
 //				attach.name = "attach" + fileNo;
 // 				fileNo = Number(fileNo) + 1;
 // 			});
  		}
  	};
	
  	
  	document.editWorkFrm.addEventListener('submit', (e) => {
  		e.preventDefault();
  		
  		// 비동기요청 파일업로드 FormData 객체 사용
  		const frmData = new FormData(e.target);	
  		
  		$.ajax({
  			url : "<%= request.getContextPath() %>/mypage/updateWork",
  			method : "POST",
  			dataType: "json",
  			data : frmData,
  			processData : false,
  			contentType : false,
  			success(work) {
  				console.log("work = ", work);
  				

  				const titleId = "workTitle" + work.no;
 				const castId = "workCast" + work.no;
 				const periodId = "workPeriod" + work.no;
 				const imgId = "workImg" + work.no;
			
 				const imgSrc = `<%= request.getContextPath() %>/upload/portfolio/\${work.attachment.renamedFilename}`;
 				
 				opener.document.getElementById(imgId).src = imgSrc;
				opener.document.getElementById(titleId).innerHTML = work.title;
				opener.document.getElementById(castId).innerHTML = work.myrole;
				opener.document.getElementById(periodId).innerHTML = work.period;
				
				alert('수정이 완료되었습니다.');
				self.close();
  			},
  			error : console.log
  		});
  	});
  </script>
</body>
</html>