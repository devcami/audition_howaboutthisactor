<%@page import="board.model.dto.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Board> list = (List<Board>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/myboard.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul id="sub">
      <li><a href="<%= request.getContextPath() %>/mypage/portfolio?memberId=<%= memberId %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/applylist" onmouseout="mouseout(this)">지원한 공고</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwUpdate" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/ckpwDelete" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
    </ul>
  </div>
  <div id="myboard">
    <div>
      <div id="myboard-head">
      	<h2>내가 쓴 게시글</h2>
        <div id="btn-sort-wrap">
          <button>삭제</button>
          <div id="sortType-wrap">
            <select id="sortType">
              <option value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : ""%>>최신순</option>
              <option value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : ""%>>오래된순</option>
            </select>
          </div>
        </div>
      </div>
      <table>
        <thead id="list-head">
          <tr>
          	<th></th>
            <th>글번호</th>
            <th>제목</th>
            <th>작성일</th>
          </tr>
        </thead>
        <tbody id="list-content">
          <tr>
          	<td><input type="checkbox" name="ck" id="ck"></td>
            <td>1</td>
            <td>가나다</td>
            <td>220204</td>
          </tr>
          <tr>
          	<td><input type="checkbox" name="ck" id="ck"></td>
            <td>2</td>
            <td>라마바</td>
            <td>220204</td>
          </tr>
          <tr>
          	<td><input type="checkbox" name="ck" id="ck"></td>
            <td>3</td>
            <td>abc</td>
            <td>220202</td>
          </tr>
        </tbody>
      </table>
      <div id="search-wrap">
        <input type="text" id="search" name="search" placeholder="제목을 검색해보세요!"/>
        <button id="btn" class="btn">검색</button>
       </div>
    </div>
    <div id="pagebar">
      <a href='/mvc/admin/memberList?cPage=1' class="page">1</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">2</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">3</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">4</a>
      <a href='/mvc/admin/memberList?cPage=1' class="page">5</a>
      <a href='/mvc/admin/memberList?cPage=6' class="page">next</a>
    </div>
  </div>

  <script>
  
	 sortType.addEventListener('change', (e) => {
	     document.querySelector("#updown-container").innerHTML = "";
	     const {value} = e.target;
	     // 공고 마감순 선택 시 페이지 요청
	     location.href=`/app/mypage/myboardEndDate?sortType=\${value}`;
	  });
	
	  const annView = (ann) => {
	     const annNo = ann.firstElementChild.lastElementChild.value;
	  	  location.href=`/app/ann/annView?annNo=\${annNo}`;
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