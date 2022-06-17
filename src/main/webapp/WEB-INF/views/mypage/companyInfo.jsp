<%@page import="member.model.dto.Production"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	Production production = (Production) request.getAttribute("production");
	String company = production.getProductionName() != null ? production.getProductionName() : "회사명을 입력해주세요.";
	String casterName = production.getCasterName() != null ? production.getCasterName() : "담당자명을 입력해주세요.";
	String casterPhone = production.getCasterPhone() != null ? production.getCasterPhone() : "담당자 연락처를 입력해주세요.";
	String casterEmail = production.getCasterEmail() != null ? production.getCasterEmail() : "담당자 이메일을 입력해주세요";
	
	// System.out.println("companyInfo.jsp@memberId = " + production.getMemberId());	
	// System.out.println("companyInfo.jsp@company = " + production.getProductionName());	
	// System.out.println("companyInfo.jsp@casterName = " + production.getCasterName());	
	// System.out.println("companyInfo.jsp@casterPhone = " + production.getCasterPhone());	
	// System.out.println("companyInfo.jsp@casterEmail = " + production.getCasterEmail());	
	
	// System.out.println(loginMember);
	
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
      <li><a href="<%= request.getContextPath() %>/mypage/applicantList" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회사 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>

     <div id="company-info">
      <div id="company_head">
        <h2>담당자 정보</h2>
        <input type="button" id="update-btn" value="수정하기" 
                onclick="edit();">
      </div>
      <form name="updateInfoFrm" method="post">
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">아이디</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="memberId" id="memberId" value="<%= loginMember.getMemberId() %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">회사명</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="companyName" id="companyName" value="<%= company %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자명</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="casterName" id="casterName" value="<%= casterName %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 번호</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="phone" id="phone" value="<%= casterPhone %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 이메일</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs"s 
          	name="email" id="email" value="<%= casterEmail %>" >
        </div>
        <div class="form-check">
          <input 
          	class="form-check-input ckinput" type="checkbox" value="Y" id="phone_open"
          	name="phone_open"
          	<%="Y".equals(production.getIsPhoneOpen()) ? "checked" : ""%> disabled>
          <label class="form-check-label" for="flexCheckDefault">
            전화번호 공개
          </label>
        </div>
        <div class="form-check">
          <input 
          	class="form-check-input ckinput" type="checkbox" value="Y" id="email_open"
          	name="email_open"
          	<%="Y".equals(production.getIsEmailOpen()) ? "checked" : ""%> disabled>
          <label class="form-check-label" for="flexCheckChecked">
            이메일 공개
          </label>
        </div>
        <div class="btn-div">
          <button type="button" id="cancelbtn" class="btn" style="display: none;" onclick="cancel();">취소</button>
          <button type="button" id="savebtn" class="btn" style="display: none;" onclick="save();">저장</button>
        </div>
      </form>
    </div> 
    
  <script>
  
  
  	const edit = () => {

  		$('.btn').css('display', '');
  		$('.inputs').attr('readonly', false);
  		$('#memberId').attr('readonly', true);
  		$(".ckinput").attr("disabled", false);
  		$('.inputs').css('border-bottom', '2px solid #bbded6');
  		$('#memberId').css('border-bottom', '');
  		$('#update-btn').css('display', 'none');
  		
  	}
  	
  	const cancel = () => {
  		alert('취소하셨습니다.');
  		
  		$('#companyName').val("<%= production.getProductionName() %>");
  		$('#casterName').val("<%= production.getCasterName() %>");
  		$('#phone').val("<%= production.getCasterPhone() %>");
  		$('#email').val("<%= production.getCasterEmail() %>");
  		
  		$('#phone_open').prop('checked', false);
  		$('#email_open').prop('checked', false);
  		
  		isPhoneOpen = "<%= production.getIsPhoneOpen() %>";
  		isEmailOpen = "<%= production.getIsEmailOpen() %>";
		
  		if(isPhoneOpen == 'Y')
  			$('#phone_open').prop('checked', true);
  		if(isEmailOpen = 'Y')
  			$('#email_open').prop('checked', true);
 
		endWork();  		

  	}
  	
  	const endWork = () => {
  		$('.btn').css('display', 'none');
  		$('.inputs').attr('readonly', true);
  		$(".ckinput").attr("disabled", true);
  		$('.inputs').css('border-bottom', '');
  		$('#update-btn').css('display', '');
  	}
  	
  	const save = () => {
  			const updateFrm = $("form[name=updateInfoFrm]").serialize();
  			console.log(updateFrm);
			
   		   $.ajax({
			   url : "<%= request.getContextPath() %>/mypage/updateProduction",
			   method : "POST",
			   dataType : "json",
			   data : updateFrm,
			   success(p){
				   alert('저장되었습니다');
				   endWork();
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