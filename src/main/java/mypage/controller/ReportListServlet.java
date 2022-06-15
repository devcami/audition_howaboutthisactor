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

import board.model.dto.Board;
import board.model.dto.Report;
import common.HelloMvcUtils;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class ReportList
 */
@WebServlet("/mypage/reportList")
public class ReportListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
//			String memberId = request.getParameter("memberId");
//			System.out.println("PwishListServlet@memberId = " + memberId);
			
			String memberId = "hosi";
			

			int numPerPage = mypageService.REPORT_NUM_PER_PAGE; // 15
			int totalContent = mypageService.getTotalReport();

			System.out.println("ReportListServlet@totalContent = " + totalContent);
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
			
			String searchType = request.getParameter("searchType");
			List<Report> list = null;
			
			if("undo".equals(searchType)) {
				list = mypageService.ReportUndoList(param);
			} else if("ing".equals(searchType)) {
				list = mypageService.ReportIngList(param);
			} else if("end".equals(searchType)) {
				list = mypageService.ReportEndList(param);
			} else {
				list = mypageService.ReportList(param);
			}
			
				System.out.println("ReportListServlet@list 길이 = " + list.size());
				System.out.println("ReportListServlet@list.get(0) = " + list.get(0));
				System.out.println("ReportListServlet@list.get(1) = " + list.get(1));
				System.out.println("ReportListServlet@list.get(2)" + list.get(2));

			
			String url = request.getRequestURI(); // /app/mypage/Pmywish
			System.out.println(url);
		
			
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
			System.out.println("pagebar =" + pagebar);
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			
			request.getRequestDispatcher("/WEB-INF/views/mypage/reportlist.jsp")
			.forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
	}

}
