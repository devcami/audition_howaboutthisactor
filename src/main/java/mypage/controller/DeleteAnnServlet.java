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
 * Servlet implementation class DeleteAnnServlet
 */
@WebServlet("/mypage/deleteAnn")
public class DeleteAnnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] deleteArr = request.getParameterValues("deleteAnn[]");
			String memberId = request.getParameter("memberId");
			
			// 출력
//			System.out.println(memberId);
//			for(String no : deleteArr) {
//				System.out.println("삭제할 no = " + no);
//			}
			
			int result = mypageService.deleteAnns(deleteArr);
			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(deleteArr, response.getWriter());
			
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
