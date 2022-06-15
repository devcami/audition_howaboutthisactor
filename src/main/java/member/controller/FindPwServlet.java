package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.dao.MemberDao;

/**
 * Servlet implementation class FindPwServlet
 */
@WebServlet("/member/findPw")
public class FindPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
		.getRequestDispatcher("/WEB-INF/views/member/findPw.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
			 request.setCharacterEncoding("utf-8");
			 
			 
			    MemberDao dao = new MemberDao();
				String memberId = request.getParameter("memberId");
				String memberName = request.getParameter("name");
				String pw = dao.findPw(memberId, memberName);
				request.setAttribute("password",  pw);
	         
	         //처리
	         String password = dao.findPw(memberId, memberName);
	         
	         //출력
	         if(password != null) {//결과가 있으면(정보가 맞다면)
	            response.sendRedirect("findPwResult.jsp?password="+password);
	            
	            request.getSession().setAttribute("password", password);
	            response.sendRedirect("findPwResult.jsp");
	         }
	         else {//결과가 없으면(정보가 맞지 않으면)
	            response.sendRedirect("findPw.jsp?error");
	         }
	      }
	      catch(Exception e) {
	         e.printStackTrace();
	      }
	}

}
