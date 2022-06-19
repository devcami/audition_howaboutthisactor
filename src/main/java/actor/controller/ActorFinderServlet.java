package actor.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import actor.model.service.ActorService;
import common.HelloMvcUtils;
import mypage.model.dto.ActorInfo;

@WebServlet("/actor/actorFinder")
public class ActorFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActorService actorService = new ActorService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String searchKeyword = request.getParameter("searchKeyword");
			 // 1. 사용자 입력값 처리
	        int numPerPage = ActorService.NUM_PER_PAGE;
	        int totalContents = actorService.getTotalContents();
	        
	        int cPage = 1;
	        try {
	           cPage = Integer.parseInt(request.getParameter("cPage"));
	        } catch(NumberFormatException e) {
	        }
	        
	        Map<String, Object> param = new HashMap<>();
	        int start = (cPage - 1) * numPerPage + 1;
	        int end = cPage * numPerPage;
	        param.put("start", start);
	        param.put("end", end);
	        param.put("searchKeyword", searchKeyword);
	        List<ActorInfo> list = actorService.findActorByName(param);
	        
	       // pagebar 영역
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContents, request.getRequestURI());
			
			
			//3. view단 처리
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request.getRequestDispatcher("/WEB-INF/views/actor/actorList.jsp").forward(request, response);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
