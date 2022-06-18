package ann.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.service.AnnService;

/**
 * Servlet implementation class AnnMorePageServlet
 */
@WebServlet("/ann/annListAsync")
public class AnnListAsyncServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 업무로직
		// 전체 게시물 수 조회 -> 전체 페이지 수 구하기
		int totalContent = annService.getTotalContent();
		int numPerPage = AnnService.NUM_PER_PAGE;
		int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		
		
		// 2. view단처리
		request.setAttribute("totalPage", totalPage);
		request.getRequestDispatcher("/WEB-INF/views/ann/annList.jsp").forward(request, response);
	}

}
