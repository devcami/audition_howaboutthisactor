package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/mypage/workView")
public class WorkViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String workNo = request.getParameter("selectedWorkNo");
		
		request.setAttribute("workNo", workNo);
		request.getRequestDispatcher("/WEB-INF/views/mypage/viewWork.jsp")
			.forward(request, response);
	}


}
