package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.dao.MemberDao;

/**
 * Servlet implementation class FindIdResultServlet
 */
@WebServlet("/member/findIdResult")
public class FindIdResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
		.getRequestDispatcher("/WEB-INF/views/member/findIdResult.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			 request.setCharacterEncoding("utf-8");
			 
			 
			    MemberDao dao = new MemberDao();
				String memberName = request.getParameter("name");
				String phone = request.getParameter("phone");
				String Id = dao.findId(memberName, phone);
				request.setAttribute("Id",  Id);
	         
	         //처리
	         String member_id = dao.findId(memberName, phone);
	         
	         //출력
	         if(member_id != null) {//결과가 있으면(정보가 맞다면)
	            response.sendRedirect("findIdResult.jsp?member_id="+member_id);
	            
	            request.getSession().setAttribute("member_id", member_id);
	            response.sendRedirect("findIdResult.jsp");
	         }
	         else {//결과가 없으면(정보가 맞지 않으면)
	            response.sendRedirect("findId.jsp?error");
	         }
		} catch(Exception e) {
        e.printStackTrace();
     }
	}

}
