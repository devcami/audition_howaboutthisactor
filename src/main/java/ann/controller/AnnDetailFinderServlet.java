package ann.controller;

import java.io.IOException;
import java.util.ArrayList;
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

@WebServlet("/ann/annDFinder")
public class AnnDetailFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int numPerPage = annService.NUM_PER_PAGE;
		int totalContent = annService.getTotalContent();
		
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
		
		//String sortType = request.getParameter("sortType");
		String url = request.getRequestURI();
		String pagebar = HelloMvcUtils.getPagebar(cPage, numPerPage, totalContent, url);
		
		List<Ann> list = annService.findAll(param);
		String annGender = request.getParameter("annGender");
		String annAge = request.getParameter("annAge");
		String annHeight = request.getParameter("annHeight");
		String annBody = request.getParameter("annBody");
		
		System.out.println(annGender + "," + annAge + "," + annHeight + "," + annBody);
		
		if(annGender != null) {
			param.put("annGender", annGender);
			list = annService.detailFinderGender(list, param);
		}
		if(annAge != null) {
			param.put("annAge", annAge);
			list = annService.detailFinderAge(list, param);
		}
		if(annHeight != null) {
			param.put("annHeight", annHeight);
			list = annService.detailFinderHeight(list, param);
		}
		if(annBody != null) {
			param.put("annBody", annBody);
			list = annService.detailFinderBody(list, param);
		}
			
		System.out.println(list);
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(list, response.getWriter());
		
	}

}
