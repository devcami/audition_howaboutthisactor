package ann.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ann.model.service.AnnService;
import mypage.model.dto.ActorInfoExt;

@WebServlet("/ann/getApplyList")
public class AnnGetApplyList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			List<ActorInfoExt> annApplyList = annService.getApplyList(memberId);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(annApplyList, response.getWriter());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
