<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String type = (String) request.getParameter("type");
	String role = (String) request.getParameter("role");
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ckpw.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <% if(role.equals("D")){ %> 
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 조회</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applicantList" onmouseout="mouseout(this)">지원자 목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/companyInfo?memberId<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">담당자 정보</a></li>
	      
	      <% if(type.equals("update")){ %>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	      
	      <% } else { %>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	      <% } %>
	    </ul>
	<% } else { %>
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applylist?memberId=<%= loginMember.getMemberId() %>" onmouseout="mouseout(this)">지원한 공고</a></li>
	      
	      <% if(type.equals("update")){ %>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	      <% } else { %>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	      <% } %>
	    </ul>
	<% } %>
  </div>
    <div id="pwck-container">
    <h2>비밀번호 확인</h2>
    <p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다. 비밀번호는 다른사람에게 노출되지 않도록 주의해주시기 바랍니다.</p>
    <div id="idpwbtn">
      <div id="idpw">
      	<div id="msg-div">
      		<span id="msg" style="display: none;">아이디 비밀번호가 일치하지 않습니다.</span>
      	</div>
        <div class="box">
          <label for="id">아이디</label>
          <input type="text" name="member_id" id="member_id" value="<%= loginMember.getMemberId() %>">
        </div>
        <div class="box">
          <label for="pw">비밀번호</label>
          <input type="password" name="pw" id="pw">
        </div>
      </div>
      <div id="btn-box">
        <button class="btn" onclick="ckidpw()">확인</button>
      </div>
    </div>
  </div>
  <form 
	name="memberDelFrm" 
	action="<%= request.getContextPath() %>/mypage/deleteMember" 
	method="POST">
	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
  </form>
  <script>
  	window.onload = () => {

  	}
  	
  	const ckidpw = () => {
  		const id = $('#member_id').val();
  		const pw = $('#pw').val();
  		const msg = "";
  	
  		if(!pw){
  			alert('비밀번호를 입력하세요');
  			return;
  		}
  		
  		$.ajax({
  			url : "<%= request.getContextPath() %>/mypage/getIdPw",
  			method: "POST",
  			dataType : "json",
  			data : {
  				"memberId" : id,
  				"password" : pw
  			},
  			success(result) {
  				console.log(result);
  				
  				if(result=="success"){
  					if('<%= type %>'=="update"){
  						location.href = `<%= request.getContextPath() %>/mypage/updateMember?memberId=<%= loginMember.getMemberId() %>`;  						
  					}
  					else {
  						// 비동기 안에 비동기 가넝한가?
  						console.log('탈퇴처리해야함');
						const msg2 = "정말 탈퇴하시겠습니까?";
						
						if(confirm(msg2)){
							document.memberDelFrm.submit();
						}
						else{
							alert('취소되었습니다.');
						}
  						
  					}
  					
  				}
  				else {
  					$('#msg').css('display','');
  				}
  			},
  			error : console.log
  		})
  	};
  
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