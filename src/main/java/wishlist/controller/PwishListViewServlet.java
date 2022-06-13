package wishlist.controller;

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
import ann.model.service.AnnService;
import common.HelloMvcUtils;
import wishlist.model.service.WishListService;

/**
 * Servlet implementation class PwishListViewServlet
 */
@WebServlet("/mypage/Pmywish")
public class PwishListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WishListService wishListService = new WishListService();
	
	/**
	 * 페이징
	 * 1. content 영역
	 * 		- cPage: 현재 페이지 변수
	 * 		- numPerPage: 한 페이지당 표시할 컨텐츠 수
	 * 		- 페이징 쿼리
	 * 			- start
	 * 			- end
	 * 
	 * 2. pagebar 영역
	 * 		- cPage: 현재 페이지 변수
	 * 		- numPerPage: 한 페이지당 표시할 컨텐츠 수
	 * 
	 * 		- totalContents: 전체컨텐츠 수
	 * 		- totalPages: 전체페이지수 (totalContents, numPerPage)
	 * 		- pagebarSize: 페이지바 길이 = 5
	 * 		- pageNo: 페이지 증감변수
	 * 		- pagebarStart ~ pagebarEnd: 페이지 범위
	 * 		- url: 다음요청 url
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
//			
//			int numPerPage = AnnService.NUM_PER_PAGE; //12
//			int totalContent = wishListService.getTotalContent();
//		
//			int cPage = 1; 
//			
//			try {
//				cPage = Integer.parseInt(request.getParameter("cPage"));
//			} catch (NumberFormatException e) {
//				// 예외 발생 : cPage가 존재하지 않을 때 , 현재 페이지는 1로 처리
//			}
//			
//			Map<String, Object> param = new HashMap<>();
//			int start = ((cPage - 1) * numPerPage ) + 1; 
//			int end = cPage * numPerPage;
//			param.put("start", start);
//			param.put("end", end);
//			
//			String sortType = request.getParameter("sortType");
//			List<Ann> list = null;
//			if("end_date".equals(sortType)) {
//				list = wishListService.annEndDateSort(param);
//			} else {
//				list = wishListService.findAll(param);
//			}
//			
//			
//			String url = request.getRequestURI(); // /mvc/admin/memberList
//			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
////			System.out.println(pagebar);
//			
//			request.setAttribute("sortType", sortType);
//			request.setAttribute("list", list);
//			request.setAttribute("pagebar", pagebar);
//			request.getRequestDispatcher("/WEB-INF/views/ann/annList.jsp").forward(request, response);
//				
			
		} catch(Exception e) {
			
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
