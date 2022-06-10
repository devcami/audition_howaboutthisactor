<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/addwork.css" />
 <link href="https://fonts.googleapis.com/css2?family=Hahmlet:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
  <div id="container">
    <form>
      <legend>경력 등록</legend>
      <table>
        <tbody>
          <tr>
            <th><label for="pic">대표사진</label></th>
            <td>
              <div id="work-img-container">
								<img src="" alt="" id="work-img"/>
							</div>
              <input type="file" name="pic" id="pic">
            </td>
          </tr>
          <tr>
            <th><label for="title">작품명</label></th>
            <td><input type="text" name="title" id="title"></td>
          </tr>
          <tr>
            <th><label for="role">배역</label></th>
            <td><input type="text" name="role" id="role"></td>
          </tr>
          <tr>
            <th><label for="period">기간</label></th>
            <td><input type="text" name="period" id="period"></td>
          </tr>
          <tr>
            <th><label for="video">참고링크</label></th>
            <td><textarea name="video" id="video" cols="35" rows="5"></textarea></td>
            <!-- <td><input type="text" name="video" id="video"></td> -->
          </tr>
          <tr>
          	<td>
           		<button>저장</button>          	
          	</td>
          </tr>
        </tbody>
      </table>
    </form>
  </div>
</body>
</html>