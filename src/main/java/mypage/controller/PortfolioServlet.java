package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dto.Member;
import mypage.model.dto.ActorInfo;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class PortfolioServlet
 */
@WebServlet("/mypage/portfolio")
public class PortfolioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
						
//			String memberId = request.getParameter("memberId");
//			String memberRole = request.getParameter("memberRole");
			
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("loginMember");
			String memberId = member.getMemberId();
			
			// 로그인한 회원이 배우회원인 경우 
			ActorInfo actorInfo = mypageService.findActorInfo(memberId);
//			System.out.println("PortfolioServlet@actorInfo = " + actorInfo.toString());
			
			if(actorInfo.getMemberId() == null) {

				request.getRequestDispatcher("/WEB-INF/views/mypage/enrollPortfolio.jsp")
					.forward(request, response);
			}
			else {
				
				int attachNo = actorInfo.getAttachNo();
				String fileName = mypageService.getRenamedFilename(attachNo);
				String img_src = request.getContextPath() + "/upload/portfolio/" + fileName;
				
				request.setAttribute("img_src", img_src);
				request.setAttribute("actorInfo", actorInfo);
				request.setAttribute("portType", "exist");
				request.getRequestDispatcher("/WEB-INF/views/mypage/viewPortfolio.jsp")
					.forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}
