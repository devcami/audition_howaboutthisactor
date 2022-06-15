package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.dto.BoardComment;
import board.model.service.BoardService;

/**
 * Servlet implementation class BoardCommentServlet
 */
@WebServlet("/board/boardCommentEnroll")
public class BoardCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			int commentLevel = Integer.parseInt(request.getParameter("commentLevel"));
			int commentRef = Integer.parseInt(request.getParameter("commentRef"));
			String memberId = request.getParameter("memberId");
			String content = request.getParameter("content");
			
			BoardComment bc = 
					new BoardComment(0, commentLevel, memberId, content, boardNo, commentRef, null);
			System.out.println("boardComment = " + bc);
			
			// 2. 업무로직
			int result = boardService.insertBoardComment(bc);
			
			// 3. 리다이렉트
			response.sendRedirect(request.getContextPath() + "/board/boardView?no=" + boardNo);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
