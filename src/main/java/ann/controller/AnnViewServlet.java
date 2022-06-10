package ann.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.dto.Ann;
import ann.model.service.AnnService;

/**
 * Servlet implementation class AnnViewServlet
 */
@WebServlet("/ann/annView")
public class AnnViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int annNo = Integer.parseInt(request.getParameter("annNo"));
			
			// 게시글 조회
			Ann ann = annService.findByAnnNo(annNo);
			
			// XSS공격(Cross-site Scripting공격) 대비 변환 : 개행처리 <br> 이전에 나와야됨!
			ann.setAnnTitle(ann.getAnnTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			
			System.out.println("annView@ann = " + ann);
			
			// 3. view단 위임
			request.setAttribute("ann", ann);
			request.getRequestDispatcher("/WEB-INF/views/ann/annView.jsp").forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
