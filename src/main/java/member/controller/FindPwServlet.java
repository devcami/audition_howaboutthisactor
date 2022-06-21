package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class FindPwServlet
 */
@WebServlet("/member/findPw")
public class FindPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/findPw.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String memberId = request.getParameter("memberId");
		 String phone = request.getParameter("phone");
		 
		 Member member = memberService.findPw(memberId, phone);
		 
		 request.setAttribute("member", member);
		 request.getRequestDispatcher("/WEB-INF/views/member/findPwResult.jsp").forward(request, response);
	}
}
