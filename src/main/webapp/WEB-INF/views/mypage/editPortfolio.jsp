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
	
	String img_src = (String) request.getAttribute("img_src");
	
	System.out.println("editPortfolio.jsp@memberId = " + memberId);
	System.out.println("editPortfolio.jsp@portType = " + portType);
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/editPortfolio.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboard" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwUpdate" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwDelete" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
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
    	<input type="hidden" name="memberId" value="<%= memberId %>" />
      <table id="portTable">
        <tbody>
          <tr>
            <th rowspan="9" id="img-th">대표사진</th>
            <td rowspan="9">
              <div id="profile-img-container">
                <img src="<%= img_src %>" id="profile-img">
              </div>
              <input type="file" name="profilePic" id="profilePic" accept="image/*" onchange="loadImage(this);">
            </td>
            <th>이름</th>
            <td colspan="3">
		      <input type="text" name="Pname" id="Pname" value="<%= memberName %>">
            </td>
          </tr>
          <tr>
            <th>생년월일</th>
            <td style="width: 150px;">
              <input type="text" name="Pbirth" id="Pbirth" value="<%= birth %>">
            </td>
            <th style="text-align: right;">나이</th>
            <td>
              <input type="text" name="Page" id="Page" value="<%= age %>" style="text-align:right;">세
            </td>
          </tr>
          <tr>
            <th>소속사</th>
            <td colspan="3">
              <input type="text" name="company" id="company" value="<%= company %>">
            </td>
          </tr>
          <tr>
            <th>학력</th>
            <td colspan="3">
              <input type="text" name="school" id="school" value="<%= education %>">
            </td>
          </tr>
          <tr>
            <th>키</th>
            <td style="width: 150px;">
              <input type="text" name="height" id="height" value="<%= height %>" style="text-align:right;">
              <span>cm</span>
            </td>
            <th style="text-align: right;">체중</th>
            <td>
              <input type="text" name="weight" id="weight" value="<%= weight %>" style="text-align:right;">
              <span>kg</span>
            </td>
          </tr>
          <tr>
            <th>휴대폰</th>
            <td colspan="3">
            	<!-- <span>010-1234-1234</span> -->
              <input type="tel" name="Pphone" id="Pphone" value="<%= phone %>">
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td colspan="3">
              <!-- <span>hosi@naver.com</span> -->
              <input type="email" name="Pemail" id="Pemail" value="<%= email %>">
            </td>
          </tr>
          <tr>
            <th>sns</th>
            <td colspan="3">
            	<!-- <span>@ho5hi_kwon</span> -->
              <input type="text" name="Psns" id="Psns" value="<%= sns %>">
            </td>
          </tr>
          <tr>
            <th>특기</th>
            <td colspan="3">
            	<!-- <span>춤</span> -->
              	<input type="text" name="Pspeciality" id="Pspeciality" value="<%= speciality %>">
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
		<tbody id="work11">
          <tr>
            <th rowspan="5" class="work-no">
            	<input type="checkbox" name="ck" value="26" class="ckbox" />
            </th>
            <td rowspan="5">
              <div id="work-img-container">
                <img src="<%= request.getContextPath() %>/upload/portfolio/20220610_231526783_055.jpg" class="work-img">
              </div>
            </td>
            <td><br><br></td>
          </tr>
          <tr class="work-tr">
            <th>작품명</th>
            <td colspan="3">스파이더</td>
          </tr>
          <tr class="work-tr">
            <th>배역</th>
            <td colspan="3">호랑이</td>
          </tr>
          <tr class="work-tr">
            <th>기간</th>
            <td colspan="3">2022.04 ~ 2022.05</td>
          </tr>
          <tr>
            <td><br><br></td>
          </tr>
        </tbody>
        
        <tbody id="work12">
       	 <tr>
          <th rowspan="5" class="work-no">
            <input type="checkbox" name="ck" value="26" class="ckbox">
          </th>
          <td rowspan="5">
            <div id="work-img-container">
              <img src="img/hosi3.jpg" id="work-img">
            </div>
          </td>
          <td><br><br></td>
        </tr>
        <tr class="work-tr">
          <th>작품명</th>
          <td colspan="3">스파이더</td>
        </tr>
        <tr class="work-tr">
          <th>배역</th>
          <td colspan="3">호랑이</td>
        </tr>
        <tr class="work-tr">
          <th>기간</th>
          <td colspan="3">2022.04 ~ 2022.05</td>
        </tr>
        <tr>
          <td><br><br></td>
        </tr>
       </tbody>
        
      </table>
    </form>
  </div>
  <form name="enrollWorkFrm" action="<%= request.getContextPath() %>/mypage/showpopup">
  	<input type="hidden" name="memberId" value="<%= memberId %>"/>
  </form>
  
  <script>
	window.onload = () => {
  		const ptable = document.getElementById("portTable"); 
  		console.log("ptable", ptable);
  		$.ajax({
  			url: "<%= request.getContextPath() %>/mypage/viewWork",
  			dataType: "json",
  			data : {
  				"memberId": "<%= memberId %>"
  			},
  			success(works){
  				
  				works.forEach((work) => {
  					console.log(work)
  					
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
  					
  				});
  				
  			},
  			error : console.log
  			
  		});  		
  		
  	}
	
	
  	const viewPort = () => {
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
  

  	
  	console.log("<%= memberId %>");  // actor2 
  	console.log("<%= portType %>");  // auto
  
	const enrollWork = () => {
  		const title = "enrollWorkPopup";
  		const spec = "width=700px, height=600px";
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
  		
  		console.log("noArr", noArr);
  		
  		$.ajax({
  			url : "<%= request.getContextPath() %>/mypage/deletework",
  			method : "POST",
  			dataType: "json",
  			data : {
  				"memberId": "<%= memberId %>",
  				"deleteWork" : noArr 
  			},
  			success(deleteArr){
  				console.log("deleteArr = ", deleteArr);
  				$.each(deleteArr, function(index, num){
 					let tbodyName = "#work" + num;
 					console.log(tbodyName);
 					
 					$("tbody").remove(tbodyName);
  				});
  				
  			},
  			error : console.log
  		});
  		
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