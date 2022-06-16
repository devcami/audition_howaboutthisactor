package mypage.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mypage.model.service.MypageService;

/**
 * Servlet implementation class DeleteBoardServlet
 */
@WebServlet("/mypage/deleteBoard")
public class DeleteBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] deleteBoard = request.getParameterValues("delBoard[]");
		String memberId = request.getParameter("memberId");
		
		// 출력
//		System.out.println(memberId);
//		for(String no : deleteBoard) {
//			System.out.println("삭제할 no = " + no);
//		}
		
		
		int result = mypageService.deleteBoards(deleteBoard);
		
		response.setContentType("pplication/json; charset=utf-8");
		new Gson().toJson(deleteBoard, response.getWriter());
	}

}
