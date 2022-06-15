package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.dto.Production;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class CompanyInfoServlet
 */
@WebServlet("/mypage/companyInfo")
public class CompanyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		try {
			String memberId = request.getParameter("memberId");
			System.out.println("memberId = " + memberId);
			
			Production production = mypageService.getProductionInfo(memberId);
			
			System.out.println(production);
			
			
			request.setAttribute("production", production);
			request.getRequestDispatcher("/WEB-INF/views/mypage/companyInfo.jsp")
			.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
