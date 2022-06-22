package mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortAttachmentExt;
import mypage.model.dto.PortfolioWorkExt;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class EditWorkServlet
 */
@WebServlet("/mypage/editWork")
public class EditWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String memberId = request.getParameter("memberId");
			int workNo = Integer.parseInt(request.getParameter("selectedWorkNo"));
			String title = request.getParameter("title");
			String cast = request.getParameter("cast");
			String period = request.getParameter("period");
			
			System.out.println("도착");
			
			System.out.println(workNo + title + cast + period);
			
			
			PortfolioWorkExt work = new PortfolioWorkExt();
			
			work.setMemberId(memberId);
			work.setNo(workNo);
			work.setTitle(title);
			work.setMyrole(cast);
			work.setPeriod(period);
			work.setVideolink(mypageService.getVideo(workNo));
			
			List<PortAttachment> attachs = mypageService.getAllWorkAttach(memberId, workNo);

			request.setAttribute("workNo", workNo);
			request.setAttribute("work", work);
			request.setAttribute("attachs", attachs);
			request.getRequestDispatcher("/WEB-INF/views/mypage/editWork.jsp")
				.forward(request, response);

		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
