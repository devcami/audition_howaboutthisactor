<%@page import="board.model.dto.Report"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Member> list = (List<Member>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");	
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/searchMember.css" />
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <ul>
      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원조회</a></li>
      <li><a href="<%= request.getContextPath() %>/mypage/reportList" onmouseover="mousein(this);" onmouseout="mouseout(this)">신고내역</a></li>
    </ul>
  </div>
  <div id="myboard">
	<div>
      <div id="myann_head">
        <h2>회원 조회</h2>
        <div id="condition">
          <select name="searchType" id="searchType">
          	<option value="member_All" 
          	<%= searchKeyword == null ? "selected" : "" %>>전체</option>
            <option value="member_Id" <%="member_Id".equals(searchType)?"selected":""%>>아이디</option>
            <option value="member_Role" <%="member_Role".equals(searchType)?"selected":""%>>회원유형</option>
            <option value="member_Name" <%="member_Name".equals(searchType)?"selected":""%>>회원명</option>
          </select>
          <div id="search-memberAll">
	          <form name="ViewAllMemberFrm" action="<%=request.getContextPath()%>/mypage/memberList"></form>
          </div>
          
          <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/mypage/memberFinder?searchType=<%= searchType%>&?searchKeyword=<%= searchKeyword %>">
              <input type="hidden" name="searchType" value="member_Id">
              <input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 아이디를 입력하세요."
              		 value="<%= "member_Id".equals(searchType) ? searchKeyword : "" %>">
              <button type="submit" class="btn">검색</button>
            </form>
          </div>
          <div id="search-memberRole" class="search-type">
            <form action="<%=request.getContextPath()%>/mypage/memberFinder?searchType=<%= searchType%>&?searchKeyword=<%= searchKeyword %>">
              <input type="hidden" name="searchType" value="member_Role">
              <input type="radio" name="searchKeyword" value="P" class="radio-btn"
              		 <%="member_Role".equals(searchType) && "P".equals(searchKeyword)?"checked":""%>>P
              <input type="radio" name="searchKeyword" value="D" class="radio-btn"
              		 <%="member_Role".equals(searchType) && "D".equals(searchKeyword)?"checked":""%>>D
              <button type="submit" class="btn">검색</button>
            </form>
          </div>
          <div id="search-memberName" class="search-type">
			<form action="<%=request.getContextPath()%>/mypage/memberFinder?searchType=<%= searchType%>&?searchKeyword=<%= searchKeyword %>">
				<input type="hidden" name="searchType" value="member_Name">
	            <input type="text" name="searchKeyword" class="keyword-input" placeholder="검색할 이름을 입력하세요."
	            	   value="<%= "member_Name".equals(searchType) ? searchKeyword : "" %>">
	            <button type="submit" class="btn">검색</button>
			</form>
          </div>
        </div>
      </div>
      <table>
        <thead id="list-head">
          <tr>
            <th>아이디</th>
            <th>회원유형</th>
            <th>이름</th>
            <th>이메일</th>
            <th>가입일</th>
          </tr>
        </thead>
        <tbody id="list-content">
<%
	if(list != null && !list.isEmpty()){
		for(Member member : list){
%>	
          <tr>
            <td><%= member.getMemberId() %></td>
            <td><%= member.getMemberRole() %></td>
            <td><%= member.getMemberName() %></td>
            <td><%= member.getEmail() != null ? member.getEmail() : "" %></td>
            <td><%= member.getBirthday() != null ? member.getBirthday() : "" %></td>
          </tr>
<%
			}
		}
		else {
%>			
			<tr>
				<td colspan="10">조회된 회원이 없습니다.</td>
			</tr>
<%
		}
%>	
        </tbody>
      </table>
    </div>
	<div id="pagebar">
		<%= pagebar %>
	</div>
  </div>

  <script>
  const mousein = (menu) => {
      now_menu.classList.remove('current');
      menu.classList.add('current');
    };

    const mouseout = (menu) => {
      now_menu.classList.add('current');
      menu.classList.remove('current');
    }
    
    window.onload = () => {
		if("<%= searchKeyword %>" != null){
			console.log("null임다");
			const value = $("#searchType option:selected").val()
			
		     switch(value) {
		       case "member_Id": 
		    	   id = "search-memberId"; 
		    	   $('#searchType').css("margin-bottom", '0');
		    	   break;
		       case "member_Role": 
		    	   id = "search-memberRole"; 
		    	   $('#searchType').css("margin-bottom", '0');
		    	   break;
		       case "member_Name": 
		    	   id = "search-memberName"; 
		    	   $('#searchType').css("margin-bottom", '0');
		    	   break;
		       case "member_All" : 
		    	   id = "search-memberAll"; 
		    	   break;
		     }
			document.querySelector(`#\${id}`).style.display = "inline-block";
			
		}
    }

    searchType.addEventListener('change', (e) => {
      const {value} = e.target;

      document.querySelectorAll('.search-type').forEach((div) => {
        div.style.display = "none";
      });
      
      let id = "";
      if(value == "member_All") {
    	  $('#searchType').css("margin-bottom", '15px');
    	  document.ViewAllMemberFrm.submit();
      }
      switch(value) {
        case "member_Id": id = "search-memberId"; break;
        case "member_Role": id = "search-memberRole"; break;
        case "member_Name": id = "search-memberName"; break;
      }
      $('#searchType').css("margin-bottom", '0');
      document.querySelector(`#\${id}`).style.display = "inline-block";
    });
  </script>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>