package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mypage.model.dto.ActorInfo;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class GotoEditPortfolioServlet
 */
@WebServlet("/mypage/gotoEditPortfolio")
public class GotoEditPortfolioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			String portType = request.getParameter("portType");
			int attachNo = Integer.parseInt(request.getParameter("attachNo"));
					
			System.out.println("GotoEditPortfolioServlet@memberId = " + memberId);
			System.out.println("GotoEditPortfolioServlet@portType = " + portType);
			System.out.println("GotoEditPortfolioServlet@attachNo 첫번째 = " + attachNo);
		
			ActorInfo actorInfo = mypageService.findActorInfo(memberId);
			System.out.println("GotoEditPortfolioServlet@attachNo 두번째 = " + actorInfo.getAttachNo());
			
			String img_src = request.getContextPath() + "/images/default.png"; 
//			const img_src = `<%= request.getContextPath() %>/upload/portfolio/\${work.attachment.renamedFilename}`;
			
			if(portType.equals("exist")) {
				attachNo = actorInfo.getAttachNo();
				String fileName = mypageService.getRenamedFilename(attachNo);
				img_src = request.getContextPath() + "/upload/portfolio/" + fileName;
				
			} else {
				actorInfo.setAttachNo(130);
			}
			
			System.out.println("GotoEditPortfolioServlet@actorInfo = " + actorInfo.toString());
//			System.out.println("GotoEditPortfolioServlet@img_src = " + img_src);
			
			request.setAttribute("img_src", img_src);
			request.setAttribute("actorInfo", actorInfo);
			request.setAttribute("portType", portType);
			request.getRequestDispatcher("/WEB-INF/views/mypage/editPortfolio.jsp")
			.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
