package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dto.Member;
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
			  	 HttpSession session = request.getSession();
			  	 Member member = (Member) session.getAttribute("loginMember");
		         String memberId = member.getMemberId();
		         
		         System.out.println(member.getMemberId());
//		         String memberId = request.getParameter("memberId");
//		         System.out.println("memberId = " + memberId);
			
		    
		         int result = mypageService.isProduction(memberId);
		         
		         if(result == 0) {
		 			request.getRequestDispatcher("/WEB-INF/views/mypage/noCompanyInfo.jsp")
					.forward(request, response);
		         } else {
			         Production production = mypageService.getProductionInfo(memberId);
			         production.setMemberId(memberId);
			        // System.out.println(production);
			         
					request.setAttribute("production", production);
					request.getRequestDispatcher("/WEB-INF/views/mypage/companyInfo.jsp")
					.forward(request, response);
		         }

		} catch(Exception e) {
			e.printStackTrace();
		}
	}


}
