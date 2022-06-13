package ann.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.dto.Ann;
import ann.model.service.AnnService;

@WebServlet("/ann/annUpdate")
public class AnnUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int annNo = Integer.parseInt(request.getParameter("annNo"));
		Ann ann = annService.findByAnnNo(annNo);
		request.setAttribute("ann", ann);
		request.getRequestDispatcher("/WEB-INF/views/ann/annUpdate.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
