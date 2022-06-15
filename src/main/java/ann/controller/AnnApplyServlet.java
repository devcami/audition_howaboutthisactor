package ann.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.service.AnnService;

@WebServlet("/ann/annApply")
public class AnnApplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int annNo = Integer.parseInt(request.getParameter("annNoApply"));
			String memberId = request.getParameter("memberId");
			Map<String, Object> param = new HashMap<>();
			param.put("annNo", annNo);
			param.put("memberId", memberId);
			
			int result = annService.insertAnnApply(param);
			request.setAttribute("msg", "지원이 완료되었습니다.");
			response.sendRedirect(request.getContextPath() + "/ann/annView?annNo=" + annNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
