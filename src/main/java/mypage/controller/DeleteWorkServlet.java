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
 * Servlet implementation class DeleteWorkServlet
 */
@WebServlet("/mypage/deletework")
public class DeleteWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
//			String memberId = request.getParameter("memberId"); // 여기서 안씀
			String[] deleteArr = request.getParameterValues("deleteWork[]");
			String memberId = request.getParameter("memberId");
			System.out.println("DeleteWorkServlet@memberId = " + memberId);
			
			for(String no : deleteArr) {
				System.out.println("삭제할 no = " + no);
			}
			
			int result = mypageService.deleteWorks(deleteArr);
			for(String no : deleteArr) {
				System.out.println("지운 no = " + no);
			}
			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(deleteArr, response.getWriter());
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
