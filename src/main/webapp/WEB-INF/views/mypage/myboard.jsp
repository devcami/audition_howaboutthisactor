<%@page import="board.model.dto.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/myboard.css" />
<%
	List<Board> list = (List<Board>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	
%>
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
          <button onclick="deleteBoard();">삭제</button>
          <div id="sortType-wrap">
            <select id="sortType">
              <option value="reg_date" id="reg_date" <%="reg_date".equals(sortType) ? "selected" : "" %>>최신순</option>
              <option value="end_date" id="end_date" <%="end_date".equals(sortType) ? "selected" : "" %>>오래된순</option>
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
        <% if(list != null && !list.isEmpty()){
				for(int i = 0; i < list.size(); i++){ 
		%>
          <tr class="trs" id="tr<%= list.get(i).getNo() %>" >
          	<td><input type="checkbox" name="ck" class="ckbox" id="ck<%= list.get(i).getNo() %>" value="<%= list.get(i).getNo() %>"></td>
            <td><%= list.get(i).getNo() %></td>
            <td><a href="보드로넘어가자"><%= list.get(i).getTitle() %></a></td>
            <td><%= list.get(i).getRegDate() %></td>
          </tr>
  	<% 	} %>
		<% } else { %>
			<p>조회된 공고가 없습니다.</p>
		<% } %>
        </tbody>
      </table>
      <div id="search-wrap">
        <input type="text" id="search" name="search" placeholder="제목을 검색해보세요!"/>
        <button id="btn" class="btn">검색</button>
       </div>
    </div>
	<div id="pagebar">
		<%= pagebar %>
	</div>
  </div>

  <script>
  	
	const deleteBoard = () => {
  		console.log("버튼선택");	
  		
  		let delBoard = [];
  		$("input[name=ck]:checked").each(function(){
  			let chk = $(this).val();
  			delBoard.push(chk);
  		});
  		
  		const msg = `\${delBoard.length}개의 게시글을 선택하셨습니다. 삭제하시겠습니까?`;
  		if(confirm(msg)){
  			// 확인 눌렀을 경우
  			
  			$.ajax({
  				url : "<%= request.getContextPath() %>/mypage/deleteBoard",
  				method : "POST",
  				dataType : "json",
  				data : {
  					"memberId" : "<%= memberId %>",
  					"delBoard" : delBoard
  				},
  				success(arrs){
  					console.log("arrs = ", arrs);
  					$.each(arrs, function(index, num){
  						console.log("num = ", num);
  						let trName = "#tr" + num;
  						console.log(trName);
  						
  						$(".trs").remove(trName);
  						
  					});
  					alert('게시글이 삭제되었습니다.');
  					location.reload();
  				},
  				error : console.log
  			});
  			
  		} else {
  			$( '.ckbox' ).prop( 'checked', false );
  		};
  		
  	}

  	
  
	 sortType.addEventListener('change', (e) => {
	     document.querySelector("#list-content").innerHTML = "";
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