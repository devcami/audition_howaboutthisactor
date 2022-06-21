package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.HelloMvcUtils;
import member.model.service.MemberService;

@WebServlet("/member/findPwResult")
public class FindPwResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
		.getRequestDispatcher("/WEB-INF/views/member/findPwResult.jsp")
		.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			String newPw = HelloMvcUtils.encrypt(request.getParameter("newPw"), memberId);
			int result = memberService.updatePw(memberId, newPw);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
