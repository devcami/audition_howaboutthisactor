<%@page import="member.model.dto.Production"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	Production production = (Production) request.getAttribute("production");

	System.out.println(production.getIsPhoneOpen());
	System.out.println(production.getIsEmailOpen());
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/companyInfo.css" />

<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 조회</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>&memberRole=<%= loginMember.getMemberRole() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회사 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>

     <div id="company-info">
      <div id="company_head">
        <h2>회사 정보</h2>
        <input type="button" id="update-btn" value="수정하기" 
                onclick="edit();">
      </div>
      <form name="updateInfoFrm" method="post">
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">아이디</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="memberId" id="memberId" value="<%= production.getMemberId() %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">회사명</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="companyName" id="companyName" value="<%= production.getProductionName() %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자명</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="memberId" id="memberId" value="<%= production.getCasterName() %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 번호</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="phone" id="phone" value="<%= production.getCasterPhone() %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 이메일</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs"s 
          	name="email" id="email" value="<%= production.getCasterEmail() %>" >
        </div>
        <div class="form-check">
          <input 
          	class="form-check-input" type="checkbox" value="phone_open" id="flexCheckDefault"
          	<%="Y".equals(production.getIsPhoneOpen()) ? "checked" : ""%> disabled>
          <label class="form-check-label" for="flexCheckDefault">
            전화번호 공개
          </label>
        </div>
        <div class="form-check">
          <input 
          	class="form-check-input" type="checkbox" value="email_open" id="flexCheckChecked"
          	<%="Y".equals(production.getIsEmailOpen()) ? "checked" : ""%> disabled>
          <label class="form-check-label" for="flexCheckChecked">
            이메일 공개
          </label>
        </div>
        <div class="btn-div">
          <button id="cancelbtn" class="btn" style="display: none;">취소</button>
          <button id="savebtn" class="btn" style="display: none;">저장</button>
        </div>
      </form>
    </div> 
<!-- 깃 풀리퀘용 -->
  <script>
  	const edit = () => {
  		$('.btn').css('display', '');
  		$('input').prop.('readonly', false);
  		
  		
		   $.ajax({
			   url : "<%= request.getContextPath() %>/mypage/deleteAnn",
			   method : "POST",
			   dataType : "json",
			   data : {
				   "memberId" : "<%= loginMember.getMemberId() %>",
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