package board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import board.model.service.BoardService;

@WebServlet("/board/boardReport")
public class BoardReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		request.setCharacterEncoding("UTF-8");
		int no = Integer.parseInt(request.getParameter("boardNoReport"));
		String memberId = request.getParameter("reportWriter");
		String reportContent = request.getParameter("reportContent");
		Map<String, Object> param = new HashMap<>();
	
		param.put("no", no);
		param.put("memberId", memberId);
		param.put("reportContent", reportContent);
		
		int result = boardService.insertBoardReport(param);
		request.getSession().setAttribute("msg", "게시글을 신고했습니다.");
		response.sendRedirect(request.getContextPath() + "/board/boardView?no=" + no);
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

}
