package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.HelloMvcUtils;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class GetidPwServlet
 */
@WebServlet("/mypage/getIdPw")
public class GetidPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			String input_pw = HelloMvcUtils.encrypt(request.getParameter("password"), memberId);
			
			String pw = mypageService.getPw(memberId);
			String result = "";
			

			if(input_pw.equals(pw)) {
				result = "success";
			}
			else {
				result = "fail";
			}
			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
