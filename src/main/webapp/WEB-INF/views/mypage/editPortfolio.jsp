<%@page import="mypage.model.dto.PortAttachment"%>
<%@page import="mypage.model.dto.ActorInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String portType = (String) request.getAttribute("portType");
	ActorInfo actor = (ActorInfo) request.getAttribute("actorInfo");

	String memberName = actor.getActorName() != null ? actor.getActorName() : "";
	String birth = actor.getBirth() != null ? actor.getBirth() : "";
	String age = actor.getAge() != 0 ? Integer.toString(actor.getAge()) : "";

	String company = actor.getCompany() != null ? actor.getCompany() : "";
	String education = actor.getEducation() != null ? actor.getEducation() : "";
	String height = actor.getHeight() != 0 ? Double.toString(actor.getHeight()) : "";
	String weight = actor.getWeight() != 0 ? Double.toString(actor.getWeight()) : "";
	
	String phone = actor.getPhone() != null ? actor.getPhone() : "";
	String email = actor.getEmail() != null ? actor.getEmail() : "";
	String sns = actor.getSns() != null ? actor.getSns() : "";
	String speciality = actor.getSpeciality() != null ? actor.getSpeciality() : "";
	int attachNo = actor.getAttachNo();
	
	String img_src = (String) request.getAttribute("img_src");
	
//	System.out.println("editPortfolio.jsp@memberId = " + loginMember.getMemberId());
//	System.out.println("editPortfolio.jsp@portType = " + portType);
//	System.out.println("editPortfolio.jsp@attachNo = " + attachNo);

%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/editPortfolio.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="portfolio-container">
    <div id="portfolio_head">
      <h2>포트폴리오</h2>
      <input type="button" id="update-btn" value="저장" class="btn" 
              onclick="viewPort();">
    </div>
    <form 
    	name="portfolioFrm" 
    	method="post"
    	action="<%=request.getContextPath()%>/mypage/viewPortfolio"
    	enctype="multipart/form-data">
    	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
    	<input type="hidden" name="portType" value="<%= portType %>" />
    	<input type="hidden" name="attachNo" value="<%= attachNo %>" />
      <table id="portTable">
        <tbody>
          <tr>
            <th rowspan="9" id="img-th">대표사진</th>
            <td rowspan="9">
              <div id="profile-img-container">
                <img src="<%= img_src %>" id="profile-img">
              </div>              
              <input type="button" name="btn-delFile" class="del-btn" id="delFile" value="삭제" onclick="fileDelete(this);"/>
              <input type="file" name="profilePic" id="profilePic" accept="image/*" onchange="loadImage(this);" style="display: none;">
            </td>
            <th>이름</th>
            <td colspan="3">
		      <input type="text" name="Pname" id="Pname" value="<%= memberName %>" placeholder="ex) 권순영">
            </td>
          </tr>
          <tr>
            <th>생년월일</th>
            <td style="width: 150px;">
              <input type="text" name="Pbirth" id="Pbirth" value="<%= birth %>" placeholder="ex) 1996-06-15">
            </td>
            <th style="text-align: right;">나이</th>
            <td>
              <input type="text" name="Page" id="Page" value="<%= age %>" style="text-align:right;" readonly>세
            </td>
          </tr>
          <tr>
            <th>소속사</th>
            <td colspan="3">
              <input type="text" name="company" id="company" value="<%= company %>" placeholder="ex) 플레디스 엔터테인먼트">
            </td>
          </tr>
          <tr>
            <th>학력</th>
            <td colspan="3">
              <input type="text" name="school" id="school" value="<%= education %>" placeholder="ex) 한양대학교 연극영화과">
            </td>
          </tr>
          <tr>
            <th>키</th>
            <td style="width: 150px;">
              <input type="text" name="height" id="height" value="<%= height %>" style="text-align:right;" placeholder="ex) 177">
              <span>cm</span>
            </td>
            <th style="text-align: right;">체중</th>
            <td>
              <input type="text" name="weight" id="weight" value="<%= weight %>" style="text-align:right;" placeholder="ex) 64.8">
              <span>kg</span>
            </td>
          </tr>
          <tr>
            <th>휴대폰</th>
            <td colspan="3">
            	<!-- <span>010-1234-1234</span> -->
              <input type="tel" name="Pphone" id="Pphone" value="<%= phone %>" placeholder="ex) 010-1234-1234">
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td colspan="3">
              <!-- <span>hosi@naver.com</span> -->
              <input type="email" name="Pemail" id="Pemail" value="<%= email %>" placeholder="ex) hosi@naver.com">
            </td>
          </tr>
          <tr>
            <th>sns</th>
            <td colspan="3">
            	<!-- <span>@ho5hi_kwon</span> -->
              <input type="text" name="Psns" id="Psns" value="<%= sns %>" placeholder="ex) @ho5si">
            </td>
          </tr>
          <tr>
            <th>특기</th>
            <td colspan="3">
            	<!-- <span>춤</span> -->
              	<input type="text" name="Pspeciality" id="Pspeciality" value="<%= speciality %>" placeholder="ex) 춤">
            </td>
          </tr>
          <tr>
            <td><br></td>
          </tr>
        </tbody>
        
        <tbody id="addWork-tbody">
    	  <tr>
              <th colspan="2" id="work-wrap-th">경력</th>
              <td colspan="4" style="text-align:right;">
              	<button type="button" id="plus-btn" class="btn" onclick="enrollWork();">+</button>
              	<button type="button" id="minus-btn" class="btn" onclick="deleteWork();">ㅡ</button>
              </td>
          </tr>
          <tr>
            <td colspan="6" style="border-top: 1px solid grey;"></td>
          </tr>
		</tbody>
		<!-- 여기에 경력이 하나씩 추가됨 -->
      </table>
    </form>
  </div>
  <form name="enrollWorkFrm" action="<%= request.getContextPath() %>/mypage/showpopup">
  	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>"/>
  </form>
  <form name="editWorkFrm" action="<%= request.getContextPath() %>/mypage/editWork">
  	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>"/>
  	<input type="hidden" name="selectedWorkNo" id="selectedWorkNo"/>
  	<input type="hidden" name="title" id="Etitle" />
  	<input type="hidden" name="cast" id="Ecast" />
  	<input type="hidden" name="period" id="Eperiod" />
  </form>
  
  <script>
  	
  	$('#Pbirth').focusout(function() {
	    // input 창밖으로 focus가 나갈때  event
		
	    // Pbirth input값 가져오기
	    const _birth = $('#Pbirth').val();
	   	const birth = _birth.substring(0, 4);
	   	
	   	const currentYear = new Date().getFullYear()
	   	const age = currentYear - birth + 1;
	   	
	   	document.getElementById("Page").value = age;
	   	
  	});
  
	const fileDelete = (e) => {
		
  		// 프로필사진 이미지 소스 비우기
  		$('#profile-img').attr("src", `<%= request.getContextPath() %>/images/default.png`); 
  				
  		// 삭제하기 버튼 숨기고
  		$('#delFile').css('display', 'none');
  		// 첨부하기 버튼(input) 추가
  		$('#profilePic').css('display', '');
  		// $('#Obosspic').val

	  	let input = document.createElement('input');
  		input.setAttribute('type', 'hidden');
  		input.setAttribute('name', 'delFile');
  		input.setAttribute('value', <%= attachNo %>);
  		e.after(input);
  		e.style.display = "none";

  	};
  	
  	
	window.onload = () => {
		
		const portType = "<%= portType %>";
		console.log("portType = ", portType);
		if(portType == "New"){
			$('#delFile').css('display', 'none');
			$('#profilePic').css('display', '');
		}
		
  		const ptable = document.getElementById("portTable"); 
  		console.log("ptable", ptable);
  		$.ajax({
  			url: "<%= request.getContextPath() %>/mypage/viewWork",
  			dataType: "json",
  			data : {
  				"memberId": "<%= loginMember.getMemberId() %>"
  			},
  			success(works){
  				
  				works.forEach((work) => {
  					console.log(work)
  					console.log("work.no=", work.no);
  					
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
  	  		         <tbody>`;
  	  				
  	  				ptable.insertAdjacentHTML('beforeend', trs);
  					
  				});
  				
  			},
  			error : console.log
  			
  		});  		
  		
  	}
	
	  const editWork = (e) => {
		  const workNo = e.getAttribute('value');
		  const tbodyId = "work" + workNo;
		  document.getElementById("selectedWorkNo").value = workNo;
		  console.log($('#selectedWorkNo').val())
		  
		  const titleId = "workTitle" + workNo;
		  const castId = "workCast" + workNo;
		  const periodId = "workPeriod" + workNo;
		  
		  const title = document.getElementById(titleId).innerHTML;
		  const cast = document.getElementById(castId).innerHTML;
		  const period = document.getElementById(periodId).innerHTML;

		  console.log(title, cast, period);
		  
		  document.getElementById("Etitle").value = title;
		  document.getElementById("Ecast").value = cast;
		  document.getElementById("Eperiod").value = period;
		  
		  const popupTitle = "viewEditWorkPopup";
          const spec = "width=650px, height=600px";
          const popup = open("", popupTitle, spec);
      
          const frm = document.editWorkFrm;
          frm.target = popupTitle; // 해당 팝업에서 폼을 제출 
          frm.submit();
         
	  }
	  
  	const viewPort = () => {
  			
		if(Pbirth.value != ''){
			// birth
			if(!/^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/.test(Pbirth.value)) {
				alert("유효한 생년월일을 형식에 맞게 입력하세요.");
				return false;
			}
		}
		
		if(Pphone.value != '') {
			// phone
			if(!/^010-\d{4}-\d{4}$/.test(Pphone.value)){
				alert("유효한 전화번호를 형식에 맞게 입력하세요.");
				return false;
			}
		}	
		
		if(Pemail.value != ''){
			// email
			if(!/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/.test(Pemail.value)){
				alert("유효한 이메일을 작성해주세요.");
				return false;
			}
		}
		
		if(height.value != ''){
			// height
			if(!/^[1-9]\d{2}(\.[0-9]+)?$/.test(height.value)){
				alert("유효한 키를 입력하세요.");
				return false;
			}
		}
		
		if(weight.value != ''){
			// height
			if(!/^[1-9]\d{2}(\.[0-9]+)?$/.test(height.value)){
				alert("유효한 체중을 입력하세요.");
				return false;
			}
		}
  		
  		document.portfolioFrm.submit();
  	}
  	
	
  const loadImage = (input) => {
  		console.log(input.files);
  		if(input.files[0]){
  			const fr = new FileReader();
  			fr.readAsDataURL(input.files[0]);
  			fr.onload = (e) => {
  				console.log(e.target.result);
  				document.querySelector("#profile-img").src = e.target.result
  			}
  		}
  	}	
  
	const enrollWork = () => {
  		const title = "enrollWorkPopup";
  		const spec = "width=650px, height=600px";
  		const popup = open("", title, spec);
  		
  		const frm = document.enrollWorkFrm;
  		frm.target = title; // 해당 팝업에서 폼을 제출 
  		frm.submit();
  	}
	
  	const deleteWork = () => {
  		
  		const noArr = [];
  		
  		$('input:checkbox[name=ck]').each(function (index) {
  			if($(this).is(":checked")==true){
  		    	// console.log($(this).val());
  		    	noArr.push($(this).val());
  		    }
  		});
  		
  		if(noArr.length == 0){
  			alert('삭제할 파일을 선택해주세요');
  			return;
  		}
  		
  		const msg = "총 " + noArr.length + "개의 파일이 선택되었습니다. 삭제하시겠습니까?"
  		
  		const check = confirm(msg);
  		
  		if(check){
  	  		$.ajax({
  	  			url : "<%= request.getContextPath() %>/mypage/deletework",
  	  			method : "POST",
  	  			dataType: "json",
  	  			data : {
  	  				"memberId": "<%= loginMember.getMemberId() %>",
  	  				"deleteWork" : noArr 
  	  			},
  	  			success(deleteArr){
  	  				console.log("deleteArr = ", deleteArr);
  	  				$.each(deleteArr, function(index, num){
  	 					let tbodyName = "#work" + num;
  	 					console.log(tbodyName);
  	 					
  	 					$("tbody").remove(tbodyName);
  	  				});
  	  				alert('경력이 삭제되었습니다.');
  	  			},
  	  			error : console.log
  	  		});
  		} else {
  	  		$('input:checkbox[name=ck]').prop('checked', false);
  		}
  		

  		
  	}
 
  
    const mousein = (menu) => {
      now_menu.classList.remove('current');
      menu.classList.add('current');
    };
  
    const mouseout = (menu) => {
      now_menu.classList.add('current');
      menu.classList.remove('current');
    }
    
    /**
     * 스크롤기능 안쳐먹음ㅠㅠ 
     * let currentPosition = $("#Pmypage-submenu").css("top"); 
     * 이새끼가 auto나옴 시부럴
     */
     let currentPosition = $("#Pmypage-submenu").css("top");
     console.log(currentPosition); 
     $(window).scroll(function(){   
        let position = $(window).scrollTop();
        $("#Pmypage-submenu").stop().animate({"top":position+currentPosition+"px"},1000);
      });
  </script>
  
  
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>