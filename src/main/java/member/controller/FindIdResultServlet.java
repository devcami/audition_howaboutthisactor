package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import member.model.service.MemberService;

/**
 * Servlet implementation class FindIdResultServlet
 */
@WebServlet("/member/findIdResult")
public class FindIdResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
		.getRequestDispatcher("/WEB-INF/views/member/findIdResult.jsp")
		.forward(request, response);
	}
	*/
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			
			request.setCharacterEncoding("utf-8");
			
		 String memberName = request.getParameter("memberName");
		 String phone = request.getParameter("phone");
		 System.out.println("memberId@findIdResulteServlet = " + memberName + phone);
		 
		 String Id = memberService.findId(memberName, phone);
		 System.out.println(Id);
		 
		 if(Id != null) {
		 request.setAttribute("Id",  Id);
		 request
			.getRequestDispatcher("/WEB-INF/views/member/findIdResult.jsp")
			.forward(request, response);
		 } else {
			 request.setAttribute("Id",  null);
			 request
				.getRequestDispatcher("/WEB-INF/views/member/findIdResult.jsp")
				.forward(request, response);
		 }
		 
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	         
		 /*   
	    		try {
	    
	     	String memberName = request.getParameter("name");
		 	String phone = request.getParameter("phone");
	   
	       //처리
	         Member Id = memberService.findId(memberName, phone);
	         
	         //출력
	         if(Id != null) {//결과가 있으면(정보가 맞다면)
	            response.sendRedirect("findIdResult.jsp?member_id="+ Id);
	            
	            request.getSession().setAttribute("member_id", Id);
	            response.sendRedirect("findIdResult.jsp");
	         }
	         else {//결과가 없으면(정보가 맞지 않으면)
	            response.sendRedirect("findId.jsp?error");
	         } 
	         		} catch(Exception e) {
        e.printStackTrace();
     			}
	      
         */
	}

}


