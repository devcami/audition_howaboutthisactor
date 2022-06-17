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

import board.model.dto.Board;
import common.HelloMvcUtils;
import member.model.dto.Member;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class MyboardServlet
 */
@WebServlet("/mypage/myboardd")
public class MyboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			HttpSession session = request.getSession();
	        Member member = (Member) session.getAttribute("loginMember");
	        String memberId = member.getMemberId();
			

			int numPerPage = mypageService.BOARD_NUM_PER_PAGE; // 12
			int totalContent = mypageService.getTotalMyBoard(memberId);

			System.out.println("MyBoardServlet@totalContent = " + totalContent);
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
			List<Board> list = null;
			
			if("end_date".equals(sortType)) {
				list = mypageService.myBoardEndDateSort(memberId, param);
			} else {
				list = mypageService.findMyAllBoard(memberId, param);
			}
			
//				System.out.println("MyBoardServlet@list 길이 = " + list.size());
//				System.out.println("MyBoardServlet@list.get(0) = " + list.get(0));
//				System.out.println("MyBoardServlet@list.get(1) = " + list.get(1));
//				System.out.println("MyBoardServlet@list.get(2)" + list.get(2));

			
			String url = request.getRequestURI(); // /app/mypage/Pmywish
			System.out.println(url);
		
			
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
			System.out.println("pagebar =" + pagebar);
			
			request.setAttribute("sortType", sortType);
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			
			request.getRequestDispatcher("/WEB-INF/views/mypage/myboard.jsp")
			.forward(request, response);

				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
