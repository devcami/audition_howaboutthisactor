package actor;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import common.HelloMvcUtils;
import member.model.dto.Member;
import member.model.service.MemberService;


/**
 * Servlet implementation class actorSearchServlet
 */


@WebServlet("/actor/actorSearch")
public class actorSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public actorSearchServlet() {
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
			RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/actor/actorSearch.jsp");
			reqDispatcher.forward(request, response);			
			
		 
		}

		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      try {
	         // 1. 인코딩
	         request.setCharacterEncoding("utf-8");
	
	         HttpSession session = request.getSession();
	         response.sendRedirect(request.getContextPath() + "/");         
	         
	      } catch(Exception e) {
	          // 1. 로깅 및 관리팀 알림.
	          e.printStackTrace();
//	          errorLogToDiscord(e);
	          // 2. 예외던지기 - tomcat에 통보
	          throw e;
	}
}
	
}

