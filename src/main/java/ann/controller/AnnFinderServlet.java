package ann.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.dto.Ann;
import ann.model.service.AnnService;

@WebServlet("/ann/annFinder")
public class AnnFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();
	/**
	 * select * from where ann_title = '%?%'
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchKeyword = request.getParameter("searchKeyword");
		List<Ann> list = annService.findByAnnTitle(searchKeyword);
		request.setAttribute("list", list);
		request.setAttribute("searchKeyword", searchKeyword);
		request.getRequestDispatcher("/WEB-INF/views/ann/annList.jsp").forward(request, response);
	}

}
