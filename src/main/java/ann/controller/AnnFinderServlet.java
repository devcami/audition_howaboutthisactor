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
import common.HelloMvcUtils;

@WebServlet("/ann/annFinder")
public class AnnFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int numPerPage = AnnService.NUM_PER_PAGE; //12
			String searchKeyword = request.getParameter("searchKeyword");
			int totalContent = annService.getTotalByTitle(searchKeyword);
		
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
			param.put("searchKeyword", searchKeyword);
			
			List<Ann> list = annService.findByAnnTitle(param);
			String url = request.getRequestURI();
			String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
			
			request.setAttribute("list", list);
			request.setAttribute("searchKeyword", searchKeyword);
			request.setAttribute("pagebar", pagebar);
			System.out.println(pagebar);
			request.getRequestDispatcher("/WEB-INF/views/ann/annList.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
