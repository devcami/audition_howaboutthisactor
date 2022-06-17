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
		request.setCharacterEncoding("UTF-8");
		int board_no = Integer.parseInt(request.getParameter("boardNoReport"));
		String memberId = request.getParameter("reportWriter");
		String reportContent = request.getParameter("reportContent");
		Map<String, Object> param = new HashMap<>();
	
		param.put("board_no", board_no);
		param.put("memberId", memberId);
		param.put("reportContent", reportContent);
		
		int result = boardService.insertBoardReport(param);
		response.sendRedirect(request.getContextPath() + "/board/boardView?board_no=" + board_no);
		
	}

}
