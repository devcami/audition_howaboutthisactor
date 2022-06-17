package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.dto.BoardExt;
import board.model.service.BoardService;

/**
 * Servlet implementation class BoardViewServlet
 */
@WebServlet("/board/boardView")
public class BoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			// 1.사용자입력값처리
			int board_no = Integer.parseInt(request.getParameter("board_no"));
			
			// 쿠키처리
			boolean hasRead = false;
			String boardCookieVal = "";
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {				
				for(Cookie cookie : cookies) {
					String name = cookie.getName();
					String value = cookie.getValue();
					if("boardCookie".equals(name)) {
						boardCookieVal = value; // 기존쿠키값
						if(value.contains("|" + board_no + "|")) {
							hasRead = true;
						}
						break;
					}
				}
			}
			
			
			// 2.업무로직
			
			// 조회수증가
			if(!hasRead) {
				int result = boardService.updateReadCount(board_no);
				// 쿠키 새로 전송 (boardCookie 없는 경우 | 요청된 boardCookie에 현재 no가 없는 경우)
				Cookie cookie = new Cookie("boardCookie", boardCookieVal + "|" + board_no + "|");
				cookie.setPath(request.getContextPath() + "/board/boardView"); // 쿠키를 사용할 경로
				cookie.setMaxAge(365 * 24 * 60 * 60); // 1년
				response.addCookie(cookie); // 응답헤더에 Set-Cookie로 전송
				System.out.println("> boardCookie가 새로 생성되었음.");
			}
			
			// 게시글 조회
			BoardExt board = boardService.findByNo(board_no);
			
			// XSS공격대비(Cross-site Scripting공격) 변환
			board.setTitle(board.getTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			board.setContent(board.getContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			
			// board#content 개행처리
			board.setContent(board.getContent().replaceAll("\n", "<br/>"));
			
			System.out.println(board);
			
			// 3.view단 위임
			request.setAttribute("board", board);
			request.getRequestDispatcher("/WEB-INF/views/board/boardView.jsp")
				.forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
	}


}
