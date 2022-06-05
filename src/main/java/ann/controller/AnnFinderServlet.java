package ann.controller;

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

/**
 * Servlet implementation class AnnFinderServlet
 */
@WebServlet("/ann/annFinder")
public class AnnFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	/**
	 * select * from ann where ann_title like '%?%'
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		Map<String, String> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		System.out.println("param = " + param);
		
		List<Ann> searchList = annService.findByTitle(param);
		System.out.println("Finder#searchList = " + searchList);
		
		request.setAttribute("searchList", searchList);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchKeyword", searchKeyword);
		request.getRequestDispatcher("/WEB-INF/views/ann/annList.jsp").forward(request, response);
		
	}

}
