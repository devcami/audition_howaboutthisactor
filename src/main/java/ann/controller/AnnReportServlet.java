package ann.controller;

import java.io.IOException;import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.service.AnnService;

@WebServlet("/ann/annReport")
public class AnnReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int annNo = Integer.parseInt(request.getParameter("annNoReport"));
		String memberId = request.getParameter("reportWriter");
		String reportContent = request.getParameter("reportContent");
		Map<String, Object> param = new HashMap<>();
	
		param.put("annNo", annNo);
		param.put("memberId", memberId);
		param.put("reportContent", reportContent);
		
		int result = annService.insertAnnReport(param);
		response.sendRedirect(request.getContextPath() + "/ann/annView?annNo=" + annNo);
		
	}

}
