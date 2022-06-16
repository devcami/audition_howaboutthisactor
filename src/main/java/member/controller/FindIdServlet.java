package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class FindIdServlet
 */
@WebServlet("/member/findId")
public class FindIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
  */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("findIdServlet 도착");
		
		request
		.getRequestDispatcher("/WEB-INF/views/member/findId.jsp")
		.forward(request, response);
	}
		 

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	

		 request.setCharacterEncoding("utf-8");

		 String memberName = request.getParameter("memberName");
		 String phone = request.getParameter("phone");
		 System.out.println("memberId@findIdServlet = " + memberName + phone);
		 
		 String Id = memberService.findId(memberName, phone);
		 boolean available = (Id == null);
		 
		 request.setAttribute("Id",  Id);
		 request.setAttribute("available", available);
		 
		
		 request
			.getRequestDispatcher("/WEB-INF/views/member/findIdResult.jsp")
			.forward(request, response);
		 
	}

}


