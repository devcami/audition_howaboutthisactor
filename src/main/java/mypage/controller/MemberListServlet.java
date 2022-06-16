package mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.HelloMvcUtils;
import member.model.dto.Member;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class MemberListServlet
 */
@WebServlet("/mypage/memberList")
public class MemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int numPerPage = MypageService.MEMBER_NUM_PER_PAGE;
			int cPage = 1;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
				// 예외발생시 현재페이지는 1로 처리 
			}
			
			Map<String, Object> param = new HashMap<>();
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			param.put("start", start);
			param.put("end", end);
			
			// 2. 업무로직 
			// 2-1. content 영역
			List<Member> list = mypageService.findAllMember(param);
//			System.out.println("list = " + list);
			
			// 2-2. pagebar 영역
			int totalContents = mypageService.getTotalMember();
			String url = request.getRequestURI();
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
//			System.out.println("pagebar = " + pagebar);
			
			// 3. view단 처리
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);			
			request.getRequestDispatcher("/WEB-INF/views/mypage/memberList.jsp")
			.forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		

		
	}

}
