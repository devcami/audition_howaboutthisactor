package ann.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AnnViewServlet
 */
@WebServlet("/ann/annView")
public class AnnViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.getRequestDispatcher("/WEB-INF/views/ann/annView.jsp").forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
