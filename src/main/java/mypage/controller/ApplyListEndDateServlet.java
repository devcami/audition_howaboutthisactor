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
import javax.servlet.http.HttpSession;

import ann.model.dto.Ann;
import common.HelloMvcUtils;
import member.model.dto.Member;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class ApplyListEndDateServlet
 */
@WebServlet("/mypage/myApplyEndDateSort")
public class ApplyListEndDateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			HttpSession session = request.getSession();
	         Member member = (Member) session.getAttribute("loginMember");
	         String memberId = member.getMemberId();
	         
			System.out.println("ApplyListEndDateServlet@memberId = " + memberId);
			
			
			List<Integer> _myApplys = mypageService.GetMyApplys(memberId);
//			System.out.println(_myApplys);
			String myApplys = "";
			
			for(int i = 0; i < _myApplys.size(); i++) {
				
				if(_myApplys.size() - 1 == i) {
					myApplys += _myApplys.get(i);				
					break;
				}
				
				myApplys += _myApplys.get(i);
				myApplys += ",";
			}
			
			System.out.println(myApplys);
			int numPerPage = mypageService.APPLY_NUM_PER_PAGE; // 8
			int totalContent = _myApplys.size();
			
			System.out.println("ApplyListServlet@totalContent = " + totalContent);
			int cPage = 1; 
			
			try {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			} catch (NumberFormatException e) {
				// 예외 발생 : cPage가 존재하지 않을 때 , 현재 페이지는 1로 처리
			}
			
			Map<String, Object> param = new HashMap<>();
			int start = ((cPage - 1) * numPerPage ) + 1; 
			int end = cPage * numPerPage;
			param.put("start", start);
			param.put("end", end);
			
			String sortType = request.getParameter("sortType");
			List<Ann> list = null;
			String url = request.getRequestURI(); // /app/mypage/Pmywish
			if("end_date".equals(sortType)) {
				list = mypageService.myApplyEndDateSort(param, myApplys);
				url += "?sortType=end_date";
			} else {
				list = mypageService.findAllMyApply(param, myApplys);
				url += "?sortType=end_date";
			}
			
			System.out.println("ApplyListServlet@list 길이 = " + list.size());
			System.out.println("ApplyListServlet@list.get(0) = " + list.get(0));
			System.out.println("ApplyListServlet@list.get(1) = " + list.get(1));
			System.out.println("ApplyListServlet@list.get(2)" + list.get(2));

			
			
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
			System.out.println("pagebaor =" + pagebar);
			
			request.setAttribute("sortType", sortType);
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			
			request.getRequestDispatcher("/WEB-INF/views/mypage/Papplylist.jsp")
			.forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
