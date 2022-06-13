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

import ann.model.dto.Ann;
import common.HelloMvcUtils;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class MyWishServlet
 */
@WebServlet("/mypage/Pmywish")
public class PwishListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			int numPerPage = mypageService.WISH_NUM_PER_PAGE; //12
//			int totalContent = mypageService.getTotalContent();
		
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
			if("end_date".equals(sortType)) {
//				list = mypageService.annEndDateSort(param);
			} else {
//				list = mypageService.findAll(param);
			}
			
			
			String url = request.getRequestURI(); // /mvc/admin/memberList
//			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
//			System.out.println(pagebar);
			
			request.setAttribute("sortType", sortType);
			request.setAttribute("list", list);
//			request.setAttribute("pagebar", pagebar);
			
			request.getRequestDispatcher("/WEB-INF/views/mypage/Pwishlist.jsp")
				.forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
