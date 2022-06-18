<%@page import="member.model.dto.Production"%>
<%@page import="ann.model.dto.Ann"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/enrollCompany.css" />

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
      <form 
      	name="updateInfoFrm" method="post"
      	action= "<%= request.getContextPath() %>/mypage/enrollCompany">
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">아이디</label>
          <input 
          	type="text" readonly class="form-control-plaintext inputs" 
          	name="memberId" id="memberId" value="<%= loginMember.getMemberId() %>" >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">회사명</label>
          <input 
          	type="text" class="form-control-plaintext inputs" 
          	name="companyName" id="companyName" value="회사명을 입력해주세요." >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자명</label>
          <input 
          	type="text" class="form-control-plaintext inputs" 
          	name="casterName" id="casterName" value="담당자명을 입력해주세요." >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 번호</label>
          <input 
          	type="text" class="form-control-plaintext inputs" 
          	name="phone" id="phone" value="담당자 번호를 입력해주세요." >
        </div>
        <div class="mb-3">
          <label for="exampleFormControlInput1" class="form-label">담당자 이메일</label>
          <input 
          	type="text" class="form-control-plaintext inputs"
          	name="email" id="email" value="담당자 이메일을 입력해주세요." >
        </div>
        <div class="form-check">
          <input 
          	class="form-check-input ckinput" type="checkbox" value="Y" id="phone_open"
          	name="phone_open">
          <label class="form-check-label" for="flexCheckDefault">
            전화번호 공개
          </label>
        </div>
        <div class="form-check">
          <input 
          	class="form-check-input ckinput" type="checkbox" value="Y" id="email_open"
          	name="email_open">
          <label class="form-check-label" for="flexCheckChecked">
            이메일 공개
          </label>
        </div>
        <div class="btn-div">
          <button type="button" id="cancelbtn" class="btn" onclick="cancel();">취소</button>
          <button type="submit" id="savebtn" class="btn">저장</button>
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
  		location.href = `<%= request.getContextPath() %>/mypage/noCompany`;

  	}
  	
  	const endWork = () => {
  		$('.btn').css('display', 'none');
  		$('.inputs').attr('readonly', true);
  		$(".ckinput").attr("disabled", true);
  		$('.inputs').css('border-bottom', '');
  		$('#update-btn').css('display', '');
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