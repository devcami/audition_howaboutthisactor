<%@page import="board.model.dto.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/myboard.css" />
<%
List<Board> list = (List<Board>) request.getAttribute("list");
	String pagebar = (String) request.getAttribute("pagebar");
	String sortType = request.getParameter("sortType");
	String searchKeyword = request.getParameter("searchKeyword");
%>
<div class="top-logo">
  <span>MYPAGE</span>
</div>
<section id="container">
  <div id="Pmypage-submenu" class="submenu">
    <% if(loginMember.getMemberRole().toString() == "D"){ %> 
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/myAnn" onmouseover="mousein(this);" onmouseout="mouseout(this)">내 공고 조회</a></li>
	      <li><a id="now_menu" class="current" onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Dmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applylist?memberId=<%= loginMember.getMemberId() %>" onmouseout="mouseout(this)">지원자 목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applicantList"  onmouseover="mousein(this);" onmouseout="mouseout(this)">담당자 정보</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      	  <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=D" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	    </ul>
	<% } else { %>
	    <ul id="sub">
	      <li><a href="<%= request.getContextPath() %>/mypage/portfolio" onmouseover="mousein(this);" onmouseout="mouseout(this)">포트폴리오</a></li>
	      <li><a id="now_menu" class="current"  onmouseover="mousein(this);" onmouseout="mouseout(this)">내가 쓴 게시글</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/Pmywish?memberId=<%= loginMember.getMemberId() %>" onmouseover="mousein(this);" onmouseout="mouseout(this)">찜목록</a></li>
	      <li><a href="<%= request.getContextPath() %>/mypage/applylist?memberId=<%= loginMember.getMemberId() %>" onmouseout="mouseout(this)">지원한 공고</a></li>
      	  <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=update&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원정보 수정</a></li>
      	  <li><a href="<%= request.getContextPath() %>/mypage/ckpw?type=del&role=P" onmouseover="mousein(this);" onmouseout="mouseout(this)">회원탈퇴</a></li>
	    </ul>
	<% } %>
    
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
       <% if(list != null && !list.isEmpty()){ %> 
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
        <%
			for(int i = 0; i < list.size(); i++){ 
		%>
          <tr class="trs" id="tr<%= list.get(i).getNo() %>" >
          	<td><input type="checkbox" name="ck" class="ckbox" id="ck<%= list.get(i).getNo() %>" value="<%= list.get(i).getNo() %>"></td>
            <td><%= list.get(i).getNo() %></td>
            <td><a href="<%= request.getContextPath() %>/board/boardView?no=<%= list.get(i).getNo() %>"><%= list.get(i).getTitle() %></a></td>
            <td><%= list.get(i).getRegDate() %></td>
          </tr>
  			<% 	} %>
  			
  			</tbody>
      	</table>
		<% } else { %>
			<p>조회된 게시물이 없습니다.</p>
		<% } %>

      <div id="search-wrap">
        <input type="text" id="search" name="search" placeholder="제목을 검색해보세요!"
        		value="<%= (searchKeyword != null) ? searchKeyword : "" %>"/>
        <button type="button" onclick="searchTitle();" id="btn" class="btn">검색</button>
      </div> 
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
  					"memberId" : "<%= loginMember.getMemberId() %>",
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
	
	const searchTitle = () => {
		const {value} = document.querySelector("#search");
		console.log(value);
		document.querySelector("#list-content").innerHTML = "";
		
		$.ajax({
			url : "<%= request.getContextPath() %>/mypage/myBoardFinder",
			method : "GET",
  			dataType : "json",
			data : {
				"searchKeyword" : value,
				"memberId" : "<%= loginMember.getMemberId() %>"
			},
			success(resp){
				const container = document.querySelector("#list-content");
				console.log(resp);
						
//				while(container.hasChildNodes()){
//					container.removeChild(container.firstChild);
//				}

	            resp.forEach((board) => {
	                console.log(board);
	                const {content, memberId, no, readCount, regDate, title} = board;
	                console.log(regDate);
	                const tr = `
	                       <tr class="trs" id="tr\${no}" >
	                          <td><input type="checkbox" name="ck" class="ckbox" id="ck\${no}" value="\${no}"></td>
	                         <td>\${no}</td>
	                         <td><a href="<%= request.getContextPath() %>/board/boardView?no=\${no}">\${title}</a></td>
	                         <td>\${regDate}</td>
	                         </tr>`;
	                         
	                 console.log(tr);
	                 container.insertAdjacentHTML('beforeend', tr);
	             });



			},
			error : console.log
		});
		
		
	}

  	
  
	 sortType.addEventListener('change', (e) => {
	     document.querySelector("#list-content").innerHTML = "";
	     const {value} = e.target;
	     // 공고 마감순 선택 시 페이지 요청
	     location.href=`<%= request.getContextPath() %>/mypage/myboardEndDate?sortType=\${value}`;
	  });
	
	  const annView = (ann) => {
	     const annNo = ann.firstElementChild.lastElementChild.value;
	  	  location.href=`/app/ann/annView?annNo=\${annNo}`;
	  };
  

  </script>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>