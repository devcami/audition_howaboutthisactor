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
import javax.servlet.http.HttpSession;

import common.HelloMvcUtils;
import member.model.dto.Member;
import mypage.model.dto.ActorInfo;
import wishlist.model.service.WishListService;

/**
 * Servlet implementation class DEndDateWishListServlet
 */
@WebServlet("/mypage/DendDateWishList")
public class DEndDateWishListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WishListService wishListService = new WishListService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginMember");
		String memberId = member.getMemberId();
		
		try {
			int numPerPage = wishListService.WISH_NUM_PER_PAGE; // 12
			int totalContent = wishListService.getTotalActorWishContent(memberId);

//			System.out.println("DwishListServlet@totalContent = " + totalContent);
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
			List<ActorInfo> list = null;
			
			String url = request.getRequestURI(); // /app/mypage/Dmywish
//			System.out.println(url);

			
			if(sortType.equals("end_date")) {
				list = wishListService.actorEndDateSort(memberId, param);
				url += "?sortType=end_date";
			} else {
				list = wishListService.findAllWishActor(memberId, param);
				url += "?sortType=reg_date";
			}
			
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
//			System.out.println("pagebar =" + pagebar);
			
//			System.out.println("DwishListServlet@list 길이 = " + list.size());
			
			// 출력할때 조심. 만약 2페이지에 3개 미만으로 있으면 출력할때 가져올 거 없어서 에러남 
//			System.out.println("DwishListServlet@list.get(0) = " + list.get(0));
//			System.out.println("DwishListServlet@list.get(1) = " + list.get(1));
//			System.out.println("DwishListServlet@list.get(2)" + list.get(2));

			

			
			request.setAttribute("sortType", sortType);
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			
			request.getRequestDispatcher("/WEB-INF/views/mypage/Dwishlist.jsp")
				.forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
