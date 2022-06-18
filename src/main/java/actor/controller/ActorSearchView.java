package actor.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import actor.model.service.ActorService;
import ann.model.service.AnnService;

/**
 * Servlet implementation class ActorSearchView
 */
@WebServlet("/actor/ActorSearchView")
public class ActorSearchView extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActorService actorService = new ActorService();
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 업무로직
				// 전체 게시물 수 조회 -> 전체 페이지 수 구하기
				int totalContent = actorService.getTotalContents();
				int numPerPage = ActorService.NUM_PER_PAGE;
				int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
				
				
				// 2. view단처리
				request.setAttribute("totalPage", totalPage);
				request.getRequestDispatcher("/WEB-INF/views/actor/actorSearch.jsp").forward(request, response);
	}

}
