package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CkpwServlet
 */
@WebServlet("/mypage/ckpw")
public class CkpwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String type = request.getParameter("type");
			String role = request.getParameter("role");
			
			request.setAttribute("type", type);
			request.setAttribute("role", role);
			request.getRequestDispatcher("/WEB-INF/views/mypage/ckpw.jsp")
				.forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
