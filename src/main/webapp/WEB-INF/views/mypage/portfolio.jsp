<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/portfolio.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="#" id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/myboard" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwUpdate" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwDelete" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="portfolio-container">
    <div id="portfolio_head">
      <h2>포트폴리오</h2>
      <input type="button" id="update-btn" value="저장" class="btn" 
              onclick="location.href='/app/ann/annEnroll';">
    </div>
    <form name="portfolioFrm" method="post">
      <table>
        <tbody>
          <tr>
            <th rowspan="8" id="img-th">대표사진</th>
            <td rowspan="8">
              <div id="profile-img-container">
                <img src="img/hosi2.jpg" id="profile-img">
              </div>
            </td>
            <th>이름</th>
            <td colspan="3">
              <input type="text" name="Pname" id="Pname" value="호시">
            </td>
          </tr>
          <tr>
            <th>생년</th>
            <td colspan="3">
              <input type="text" name="Pbirth" id="Pbirth" value="1996-06-15">
            </td>
          </tr>
          <tr>
            <th>소속사</th>
            <td colspan="3">
              <input type="text" name="company" id="company" value="플레디스">
            </td>
          </tr>
          <tr>
            <th>학력</th>
            <td colspan="3">
              <input type="text" name="school" id="school" value="한양대학교 미래인재교육원">
            </td>
          </tr>
          <tr>
            <th>키</th>
            <td style="width: 150px;">
              <input type="text" name="height" id="height" value="177" style="text-align:right;">
              <span>cm</span>
            </td>
            <th style="width: 80px;">체중</th>
            <td>
              <input type="text" name="weight" id="weight" value="60.9" style="text-align:right;">
              <span>kg</span>
            </td>
          </tr>
          <tr>
            <th>휴대폰</th>
            <td colspan="3">
              <input type="tel" name="Pphone" id="Pphone" value="010-1234-124">
            </td>
          </tr>
          <tr>
            <th>이메일</th>
            <td colspan="3">
              <input type="email" name="Pemail" id="Pemail" value="hosi@naver.com">
            </td>
          </tr>
          <tr>
            <th>sns</th>
            <td colspan="3">
              <input type="text" name="Psns" id="Psns" value="instagram - @ho5hi_kwon">
            </td>
          </tr>

          <tr>
            <td><br></td>
          </tr>
        </tbody>
      </table>
    </form>
    <table>
    	<tbody>
    	  <tr>
              <th colspan="2" id="work-wrap-th">경력</th>
              <td colspan="4" style="text-align:right;">
              	<button type="button" id="plus-btn" class="btn" onclick="enrollWork();">+</button>
              </td>
          </tr>
          <tr>
            <td colspan="6" style="border-top: 1px solid grey;"></td>
          </tr>

          <tr>
            <th rowspan="5" class="work-no">1</th>
            <td rowspan="5">
              <div id="work-img-container">
                <img src="img/hosi8.jpg" id="work-img">
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

          <tr>
            <th rowspan="5" class="work-no">2</th>
            <td rowspan="5">
              <div id="work-img-container">
                <img src="img/hosi3.jpg" id="work-img">
              </div>
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
  </div>
  <form name="enrollWorkFrm" action="<%= request.getContextPath() %>/mypage/showpopup">
  	<input type="hidden" name="memberId" />
  </form>
  <script>
  	const enrollWork = () => {
  		const title = "enrollWorkPopup";
  		const spec = "width=700px, height=600px";
  		const popup = open("", title, spec);
  		
  		const frm = document.enrollWorkFrm;
  		frm.target = title; // 해당 팝업에서 폼을 제출
  		frm.memberId.value = "actor";
  		frm.submit();
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