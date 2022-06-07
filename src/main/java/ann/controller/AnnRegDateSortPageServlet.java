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

/**
 * Servlet implementation class AnnMorePageServlet
 */
@WebServlet("/ann/regDatePage")
public class AnnRegDateSortPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값 처리
			int numPerPage = AnnService.NUM_PER_PAGE;
			int cPage = Integer.parseInt(request.getParameter("cPage"));
			
			Map<String, Integer> param = new HashMap<>();
			param.put("start", (cPage - 1) * numPerPage + 1);
			param.put("end", cPage * numPerPage);
			
			// 2. 업무로직
			List<Ann> list = annService.regDatePage(param);
			System.out.println("list = " + list);
			
			// 3. 응답처리 json
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(list, response.getWriter());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
