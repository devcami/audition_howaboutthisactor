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
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboard?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseover="mousein(this);" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
	  <div id="portfolio-container">
    <div id="portfolio_head">
      <h2>포트폴리오</h2>
    </div>
    <div id="portfolio-container">
      <div id="text-div">
        <p id="head-p">앗! 아직 포트폴리오 등록 전이시군요!</p>
        <p>포트폴리오가 있으면 공고 간편지원이 가능해요!</p>
        <p>배우찾기 게시판에도 내 포트폴리오가 올라간답니다!</p>
      </div>
      <div id="btn-div">
        <button type="button" id="btn-apply" onclick="enrollPort();">포트폴리오 간편등록</button>
      </div>
      <form action="">
        <input type="hidden" name="porttype" id="porttype">
      </form>
    </div>
  </div>
  <form name="enrollWorkFrm" action="<%= request.getContextPath() %>/mypage/gotoEditPortfolio">
  	<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>"/>
  	<input type="hidden" name="portType" value="New"/>
  	<input type="hidden" name="attachNo" value="130">
  </form>
  
  <script>
   
	const enrollPort = () => {
		
		document.enrollWorkFrm.submit();
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