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
 * Servlet implementation class EnrollCompanyServlet
 */
@WebServlet("/mypage/enrollCompany")
public class EnrollCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/mypage/enrollCompanyInfo.jsp")
		.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String memberId = request.getParameter("memberId");
		String companyName = request.getParameter("companyName");
		String casterName = request.getParameter("casterName");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String phone_open = request.getParameter("phone_open");
		String email_open = request.getParameter("email_open");
		
		System.out.println("EnrollCompanyServlet@memberId = " + memberId);
		System.out.println("EnrollCompanyServlet@companyName = " + companyName);
		System.out.println("EnrollCompanyServlet@casterName = " + casterName);
		System.out.println("EnrollCompanyServlet@phone = " + phone);
		System.out.println("EnrollCompanyServlet@email = " + email);
		System.out.println("EnrollCompanyServlet@phone_open = " + phone_open);
		System.out.println("EnrollCompanyServlet@email_open = " + email_open);
		
		if(email_open == null) {
			email_open = "N";					
		}
		if(phone_open == null) {
			phone_open = "N";					
		}
		
		Production production = 
				new Production(memberId, companyName, casterName, phone, email, phone_open, email_open);
		
		int result = mypageService.insertProduction(production);
		
		request.setAttribute("production", production);
		request.getRequestDispatcher("/WEB-INF/views/mypage/companyInfo.jsp")
		.forward(request, response);
	}

}
