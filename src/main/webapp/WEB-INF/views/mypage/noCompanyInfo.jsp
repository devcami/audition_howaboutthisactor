<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	System.out.println("portfolio.jsp@memberId = " + loginMember.getMemberId());
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/enrollPortfolio.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 조회</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboardd?memberId=<%= loginMember.getMemberId() %>&memberRole=<%= loginMember.getMemberRole() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applicantList" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원자 관리</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회사 정보</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
	  <div id="portfolio-container">
    <div id="portfolio_head">
      <h2>회사 정보</h2>
    </div>
    <div id="portfolio-container" style="margin-bottom: 190px;">
      <div id="text-div">
        <p id="head-p" style="margin: 10px 0 10px 0;">앗! 아직 회사정보 등록 전이시군요!</p>
        <p>회사정보를 등록하면 배우가 내공고에 지원했을때 연락을 받을 수 있어요!</p>
      </div>
      <div id="btn-div">
        <button type="button" id="btn-apply" onclick="enrollCompany();" style="width: 248px;">회사정보 간편등록</button>
      </div>
      <form action="">
        <input type="hidden" name="porttype" id="porttype">
      </form>
    </div>
  </div>
  <form name="enrollCompanyInfoFrm" action="<%= request.getContextPath() %>/mypage/enrollCompany">
  	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>"/>
  	<input type="hidden" name="companyType" value="New"/>
  </form>
  
  <script>
   
	const enrollCompany = () => {
		
		document.enrollCompanyInfoFrm.submit();
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