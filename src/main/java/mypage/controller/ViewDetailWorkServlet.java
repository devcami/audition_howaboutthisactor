package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import mypage.model.dto.PortfolioWorkExt;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class ViewDetailWork
 */
@WebServlet("/mypage/detailWork")
public class ViewDetailWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			
			int workNo = Integer.parseInt(request.getParameter("workNo"));
			String memberId = request.getParameter("memberId");
			System.out.println("ViewDetailWorkServlet@workNo = " + workNo);
			System.out.println("ViewDetailWorkServlet@memberId = " + memberId);
			
			PortfolioWorkExt work = mypageService.findWorkByNo(workNo, memberId);

			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(work, response.getWriter());
	
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
