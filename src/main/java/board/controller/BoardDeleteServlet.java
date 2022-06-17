package board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.dto.Attachment;
import board.model.service.BoardService;

/**
 * Servlet implementation class NoticeDeleteServlet
 */
@WebServlet("/board/boardDelete")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1.사용자입력처리
			int board_no = Integer.parseInt(request.getParameter("board_no"));

			// 2.업무로직
			// 첨부파일 존재시 삭제
			List<Attachment> attachments = boardService.findByNo(board_no).getAttachments();
			if(attachments != null && !attachments.isEmpty())
				for(Attachment attach : attachments) {
					String saveDirectory = getServletContext().getRealPath("/upload/board");
					File delFile = new File(saveDirectory, attach.getRenamedFilename());
					if(delFile.exists()) {
						delFile.delete();
						System.out.println("> " + attach.getRenamedFilename() + "파일 삭제!");						
					}
				}
					
			
			// board 레코드(행) 삭제 (attachment는 on delete cascade에 의해 자동으로 제거된다.)
			int result = boardService.deleteBoard(board_no);
			
			// 3. redirect : /mvc/board/boardList로 이동
			request.getSession().setAttribute("msg", "게시글을 삭제했습니다.");
			response.sendRedirect(request.getContextPath() + "/board/boardList");

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

}
