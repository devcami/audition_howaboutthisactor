package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MyBoardServlet
 */
@WebServlet("/mypage/myboard")
public class MyBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			String memberRole = request.getParameter("memberRole");
			
			System.out.println("MyBoardServlet@memberId = " + memberId);
			System.out.println("MyBoardServlet@memberRole = " + memberRole);
			
			
			
			
			request.setAttribute("memberId", memberId);
			request.setAttribute("memberRole", memberRole);
			request.getRequestDispatcher("/WEB-INF/views/mypage/myboard.jsp")
				.forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
