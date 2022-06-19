package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


@WebServlet("/mypage/workView")
public class WorkViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String workNo = request.getParameter("selectedWorkNo");
		String memberId = request.getParameter("memberId");
		System.out.println("WorkViewServlet@memberId=" + memberId);
		
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("workNo", workNo);
		request.getRequestDispatcher("/WEB-INF/views/mypage/viewWork.jsp")
			.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			
			String workNo = request.getParameter("workNo");
			String memberId = request.getParameter("memberId");
			System.out.println("ViewDetailWorkServlet@workNo = " + workNo);
			System.out.println("ViewDetailWorkServlet@memberId = " + memberId);
			
//			PortfolioWorkExt work = mypageService.findWorkByNo(workNo, memberId);

			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(memberId, response.getWriter());
	
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
