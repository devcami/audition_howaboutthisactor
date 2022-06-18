package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.model.service.MemberService;

@WebServlet("/member/idDuplicateCheck")
public class SNSIdDuplicationCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			
			int result = memberService.idDuplicationCheck(memberId);
			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(result, response.getWriter());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
