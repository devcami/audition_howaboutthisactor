package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.HelloMvcUtils;
import member.model.service.MemberService;
import member.controller.FindPwServlet;

/**
 * Servlet implementation class FindPwResultServlet
 */
@WebServlet("/member/findPwResult")
public class FindPwResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("findPwResultServlet 도착");
		request
		.getRequestDispatcher("/WEB-INF/views/member/findPwResult.jsp")
		.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
		 request.setCharacterEncoding("utf-8");
		 
		 String memberId = (String) request.getAttribute("memberId");
//		 String newpassword = HelloMvcUtils.encrypt(request.getParameter("newpassword"), memberId);
//		 System.out.println("memberId@findPwResulteServlet = " + memberId); // memberName

		 System.out.println("비밀번호 변경용 아이디 확인" + memberId);
		 
//		 request.setAttribute("newpassword",  newpassword);
		 request
			.getRequestDispatcher("/WEB-INF/views/member/findPwResult.jsp")
			.forward(request, response);
		 
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
