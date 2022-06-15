package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet("/mypage/updateMember")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

				String memberId = request.getParameter("memberId");
				System.out.println("updateMember@memberId" + memberId);
				
				request.getRequestDispatcher("/WEB-INF/views/mypage/memberUpdate.jsp")
					.forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
	}

}
