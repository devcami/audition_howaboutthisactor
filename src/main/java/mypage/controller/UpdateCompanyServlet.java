package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.model.dto.Production;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class UpdateCompanyServlet
 */
@WebServlet("/mypage/updateProduction")
public class UpdateCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
				request.setCharacterEncoding("utf-8");
				
				String memberId = request.getParameter("memberId");
				String companyName = request.getParameter("companyName");
				String casterName = request.getParameter("casterName");
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String phone_open = request.getParameter("phone_open");
				String email_open = request.getParameter("email_open");
				
				System.out.println("UpdateCompanyServlet@memberId = " + memberId);
				System.out.println("UpdateCompanyServlet@companyName = " + companyName);
				System.out.println("UpdateCompanyServlet@casterName = " + casterName);
				System.out.println("UpdateCompanyServlet@phone = " + phone);
				System.out.println("UpdateCompanyServlet@email = " + email);
				System.out.println("UpdateCompanyServlet@phone_open = " + phone_open);
				System.out.println("UpdateCompanyServlet@email_open = " + email_open);
				
				if(email_open == null) {
					email_open = "N";					
				}
				if(phone_open == null) {
					phone_open = "N";					
				}
				
				

				Production production = 
						new Production(memberId, companyName, casterName, phone, email, phone_open, email_open);
				
				int result = mypageService.updateProduction(production);
		
				response.setContentType("application/json; charset=utf-8");
				new Gson().toJson(production, response.getWriter());
		
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
