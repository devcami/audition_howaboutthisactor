package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import board.model.dto.Board;
import board.model.service.BoardService;

/**
 * Servlet implementation class BaordFinderServlet
 */
@WebServlet("/board/boardFinder")

public class BoardFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String searchKeyword = request.getParameter("searchKeyword");
		
			List<Board> list = boardService.findByBoardTitle(searchKeyword);
			
			request.setAttribute("list", list);
			request.setAttribute("searchKeyword", searchKeyword);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(list, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
