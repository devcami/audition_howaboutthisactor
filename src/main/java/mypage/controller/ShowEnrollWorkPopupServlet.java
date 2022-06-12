package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EnrollWorkServlet
 */
@WebServlet("/mypage/showpopup")
public class ShowEnrollWorkPopupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId = request.getParameter("memberId");
		
		request.setAttribute("memberId", memberId);
		request.getRequestDispatcher("/WEB-INF/views/mypage/addWork.jsp")
			.forward(request, response);
	}

}
