package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;

/**
 * Servlet implementation class BoardCommentDeleteServlet
 */
@WebServlet("/board/boardCommentDelete")
public class BoardCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1. 파라미터값 가져오기
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			int no = Integer.parseInt(request.getParameter("no"));
			System.out.println("boardNo="+boardNo+", no=" + no);
			//2. 비지니스로직 호출
			int result = boardService.deleteBoardComment(no);		
			//3. 리다이렉트
			request.getSession().setAttribute("msg", "댓글 삭제 성공!");
			response.sendRedirect(request.getContextPath() + "/board/boardView?no=" + boardNo);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

}

