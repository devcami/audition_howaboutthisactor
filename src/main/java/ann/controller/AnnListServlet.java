package ann.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.service.AnnService;

/**
 * Servlet implementation class AnnListServlet
 */
@WebServlet("/ann/annList")
public class AnnListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int totalContent = annService.getTotalContent();
			int numPerPage = AnnService.NUM_PER_PAGE;
			int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
			
			request.setAttribute("totalPage", totalPage);
			request.getRequestDispatcher("/WEB-INF/views/ann/annList.jsp").forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
