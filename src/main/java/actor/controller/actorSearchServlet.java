package actor.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import actor.model.dto.ActorExt;
import actor.model.service.ActorService;
import board.model.service.BoardService;
import common.HelloMvcUtils;
import member.model.dto.Member;
import member.model.service.MemberService;


/**
 * Servlet implementation class actorSearchServlet
 */


@WebServlet("/actor/actorSearch")
public class actorSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActorService actorService = new ActorService();
 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        // 1. 사용자 입력값 처리
        int numPerPage = 10;
        int cPage = 1;
        try {
           cPage = Integer.parseInt(request.getParameter("cPage"));
        } catch(NumberFormatException e) {}
        Map<String, Object> param = new HashMap<>();
        int start = (cPage - 1) * numPerPage + 1;
        int end = cPage * numPerPage;
        param.put("start", start);
        param.put("end", end);

	
        List<ActorExt> list = actorService.findAll(param);
        System.out.println(list);
        
        
        
			RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/actor/actorSearch.jsp");
			reqDispatcher.forward(request, response);			
			
			
			
			
			
			
			
			// 2. 업무로직
//			// pagebar 영역
			
			
			//3. view단 처리
//		 request.setAttribute(list, list);
		}

		
	
}
	


