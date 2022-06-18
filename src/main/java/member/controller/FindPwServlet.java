package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class FindPwServlet
 */
@WebServlet("/member/findPw")
public class FindPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("findPwServlet 도착");
		request
		.getRequestDispatcher("/WEB-INF/views/member/findPw.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");

		 String memberId = request.getParameter("memberId");
		 String memberName = request.getParameter("memberName");
		 System.out.println("memberID@findPwServlet = " + memberId + memberName);
		 
//		 String password = memberService.findPw(memberId, memberName);
//		 boolean available = ( password == null);
		 
		 request.setAttribute("memberId", memberId);
//		 request.setAttribute("password",  password);
//		 request.setAttribute("available", available);
		 
		
		 request
			.getRequestDispatcher("/WEB-INF/views/member/findPwResult.jsp")
			.forward(request, response);
		 
	}
}
