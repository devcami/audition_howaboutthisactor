<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
   
	List<Ann> list = (List<Ann>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/companyInfo.css" />

<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboard?memberId=<%= memberId %>&memberRole=<%= memberRole %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= memberId %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">회사 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  
  
     <div id="company-info">
      <div id="company_head">
        <h2>회사 정보</h2>
        <input type="button" id="update-btn" value="수정하기" 
                onclick="location.href='/app/ann/annEnroll';">
      </div>
      <form name="updateInfoFrm" method="post">
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">회원 아이디</label>
          <input type="text" readonly class="form-control-plaintext inputs" name="memberId" id="memberId" value="hosi" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">회사명</label>
          <input type="text" readonly class="form-control-plaintext inputs" name="companyName" id="companyName" value="숲 엔터테인먼트" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 번호</label>
          <input type="text" readonly class="form-control-plaintext inputs" name="phone" id="phone" value="010-1234-1234" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 이메일</label>
          <input type="text" readonly class="form-control-plaintext inputs" name="email" id="email" value="director@naver.com" >
        </div>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" value="phone_open" id="flexCheckDefault">
          <label class="form-check-label" for="flexCheckDefault">
            전화번호 공개
          </label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" value="email_open" id="flexCheckChecked">
          <label class="form-check-label" for="flexCheckChecked">
            이메일 공개
          </label>
        </div>
        <div class="btn-div">
          <button id="savebtn">저장</button>
        </div>
      </form>
    </div> 
  


  <script>
  
  sortType.addEventListener('change', (e) => {
      document.querySelector("#updown-container").innerHTML = "";
      const {value} = e.target;
      // 공고 마감순 선택 시 페이지 요청
      location.href=`/app/mypage/myAnnEndDate?sortType=\${value}`;
   });

   const annView = (ann) => {
      //const annNo = ann.firstElementChild.lastElementChild.value;
      const annNo = ann.currentTarget.firstElementChild.children.annNo.value;
      console.log(annNo);
   	  location.href=`/app/ann/annView?annNo=\${annNo}`;
   };
   
   $(".card").click(annView);
   
   let selectedAnn = [];
   const annSelect = (ann) => {
	   
	   if($(ann.currentTarget).hasClass("selected")){
		   $(ann.currentTarget).removeClass("selected");
	   } else {
		   $(ann.currentTarget).addClass("selected");
	   }
   } 
   
   const selectMode = () => {
	   console.log("selectMode 실행");
	   //$(".card").removeEventListener('click', annView);
	   //sortType.removeEventListener('change', sortTypeChange);
	   $(".card").off("click");
	   $('#choice-btn').css('display', 'none');
	   $('#cancel-btn').css('display', '');
	   $('#options').css('display', '');
	   
	   $(".card").click(annSelect);
	   
   };
   
   const viewMode = () => {
	   $(".card").off("click");
	   $(".card").click(annView);
	   $('#choice-btn').css('display', '');
	   $('#cancel-btn').css('display', 'none');
	   $('#options').css('display', 'none');
	   
	   const annArr = Array.from(document.querySelectorAll('.card'));
	   ckremove(annArr);
	   
   }
   
   // ann 삭제하기
   const delAnn = () => {
	   const annArr = Array.from(document.querySelectorAll('.card'));
	   
	   const selectedArr = ckselected(annArr);
	   
	   console.log(selectedArr);
	   const msg = "총 " + selectedArr.length + "개의 파일이 선택되었습니다. 삭제하시겠습니까?"
	   const check = confirm(msg);
	   
	   if(check){
		   $.ajax({
			   url : "<%= request.getContextPath() %>/mypage/deleteAnn",
			   method : "POST",
			   dataType : "json",
			   data : {
				   "memberId" : "<%= memberId %>",
				   "deleteAnn" : selectedArr
			   },
			   success(arrs){
				   console.log("arrs = ", arrs);
		           $.each(arrs, function(index, num){
		        	   console.log("num = ", num);
		        	   let colName = "#col" + num;
		        	   console.log(colName);
		           
		        	   $(".col").remove(colName);
		           });
		          alert('공고가 삭제되었습니다.');
		          location.reload();
			   },
			   error : console.log
		   });
	   } else {
		   ckremove(annArr);
	   }
   }
   
   // ann 수정하기
   const editAnn = () => {
	   const annArr = Array.from(document.querySelectorAll('.card'));
	   // console.log(annArr);
	   const selectedArr = ckselected(annArr);

	   
	   if(selectedArr.length != 1){
		   alert('수정하시려면 하나의 공고만 선택해주세요.');
	   } else {
		   console.log(selectedArr[0]);
		   location.href=`/app/ann/annUpdate?annNo=\${selectedArr[0]}`;
	   }
	   
   }
   
   const ckselected = (annArr) => {
	   let annNo = 0;
	   let selectedArr = [];
	   let i = 0;
	   annArr.forEach((ann) => {
		   annNo = ann.firstElementChild.lastElementChild.value;
		   
		   if(ann.classList.contains("selected")){
			   selectedArr[i++] = annNo;
		   }
		   // element.classList.contains(class);
		   //if($(ann.currentTarget).hasClass("selected"))
	   });
	   
	   return selectedArr;
   }
   
   const ckremove = (annArr) => {
	   annArr.forEach((ann) => {
		   if(ann.classList.contains("selected")){
			   ann.classList.remove("selected");
		   }
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
    
    
  </script>
</section>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>