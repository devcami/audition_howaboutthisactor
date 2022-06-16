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
import member.model.service.MemberService;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class MemberFinderServlet
 */
@WebServlet("/mypage/memberFinder")
public class MemberFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력값 처리
			String searchType = request.getParameter("searchType"); // member_id member_name gender
			String searchKeyword = request.getParameter("searchKeyword");
			
			Map<String, String> param = new HashMap<>();
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			System.out.println("param = " + param);
			
			
			
			
			// 추가된 부분 
			
			// 1. 사용자 입력값 처리
			int numPerPage = MypageService.MEMBER_NUM_PER_PAGE;
			int cPage = 1;
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
				// 예외발생시 현재페이지는 1로 처리 
			}
			
			Map<String, Object> pageParam = new HashMap<>();
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			pageParam.put("start", start);
			pageParam.put("end", end);
		
			// -------------------
			
			
			// 2. 업무로직
			List<Member> list = mypageService.findBy(param, pageParam);
			System.out.println("list = " + list);
			
			
			// 추가한 부분
			int totalContents = mypageService.getTotalSearchedMember(param);
			String url_1 = request.getRequestURI(); // app/mypage/memberFinder
			String url_2 = "?searchType=" + searchType + "&searchKeyword=" + searchKeyword;
			
			String url = url_1 + url_2; 
			System.out.println(url);
			
			
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
			System.out.println("pagebar = " + pagebar);
			
			// ----------------
			
			
			
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
