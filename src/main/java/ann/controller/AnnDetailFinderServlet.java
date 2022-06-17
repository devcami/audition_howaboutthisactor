package ann.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import ann.model.dto.Ann;
import ann.model.service.AnnService;

@WebServlet("/ann/annDFinder")
public class AnnDetailFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			List<Ann> list = annService.findAll();
			
			String annGender = request.getParameter("annGender");
			String annAge = request.getParameter("annAge");
			String annHeight = request.getParameter("annHeight");
			String annBody = request.getParameter("annBody");
			
			if(annGender != null) {
				list = annService.detailFinderGender(list, annGender);
			}
			if(annAge != null) {
				list = annService.detailFinderAge(list, annAge);
			}
			if(annHeight != null) {
				list = annService.detailFinderHeight(list, annHeight);
			}
			if(annBody != null) {
				list = annService.detailFinderBody(list, annBody);
			}
				
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(list, response.getWriter());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
