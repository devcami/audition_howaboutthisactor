package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EnrollPortfolioServlet
 */
@WebServlet("/mypage/enrollPort")
public class EnrollPortfolioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String memberId = request.getParameter("memberId");
			String portType = request.getParameter("portType");
			
			System.out.println("memberId = " + memberId + " portType = " + portType);
			
			request.setAttribute("memberId", memberId);
			request.setAttribute("portType", portType);
			request.getRequestDispatcher("/WEB-INF/views/mypage/editPortfolio.jsp")
			.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


}
