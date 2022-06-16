package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class FindPwResultServlet
 */
@WebServlet("/member/findPwResult")
public class FindPwResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
		 request.setCharacterEncoding("utf-8");
			
		 String memberId = request.getParameter("memberId");
		 String memberName = request.getParameter("memberName");
		 System.out.println("memberId@findIdResulteServlet = " + memberId + memberName);
		 
		 String password = memberService.findPw(memberId, memberName);
		 System.out.println(password);
		 
		 request.setAttribute("password",  password);
		 request
			.getRequestDispatcher("/WEB-INF/views/member/findPwResult.jsp")
			.forward(request, response);
		 
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
