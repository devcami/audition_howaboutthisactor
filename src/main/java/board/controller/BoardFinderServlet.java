package board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import board.model.dto.Board;
import board.model.service.BoardService;
import member.model.dto.Member;
import mypage.model.service.MypageService;
	

/**
 * Servlet implementation class BaordFinderServlet
 */
@WebServlet("/board/boardFinder")

public class BoardFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String searchType = request.getParameter("searchType"); // member_id member_name gender
			String searchKeyword = request.getParameter("searchKeyword");
			
			Map<String, String> param = new HashMap<>();
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			System.out.println("param = " + param);
			
			
			// 1. 사용자 입력값 처리
			int numPerPage = MypageService.MEMBER_NUM_PER_PAGE;
			int cPage = 1;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
				// 예외발생시 현재페이지는 1로 처리 
			}
			
			Map<String, Object> pageParam = new HashMap<>();
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			pageParam.put("start", start);
			pageParam.put("end", end);
		
		
			List<Board> list = boardService.findBy(param, pageParam);
					
			request.setAttribute("list", list);
			request.setAttribute("searchKeyword", searchKeyword);
			request.getRequestDispatcher("/WEB-INF/views/board/boardList.jsp").forward(request, response);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
