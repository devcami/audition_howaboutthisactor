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

import com.google.gson.Gson;

import ann.model.dto.Ann;
import ann.model.service.AnnService;
import common.HelloMvcUtils;

@WebServlet("/ann/annListSort")
public class AnnListSortServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String sortType = request.getParameter("sortType");
			List<Ann> list = null;
			
			if(sortType.equals("end_date")) {
				list = annService.annEndDateSort();
			} else if(sortType.equals("popular")){
				list = annService.annPopSort();
			} else {
				list = annService.findAll();
			}
			
			request.setAttribute("sortType", sortType);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(list, response.getWriter());
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

}
