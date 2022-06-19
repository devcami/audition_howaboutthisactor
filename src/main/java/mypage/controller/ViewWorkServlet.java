package mypage.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.model.dto.Production;
import mypage.model.dto.PortfolioWork;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class ViewWorkServlet
 */
@WebServlet("/mypage/viewWork")
public class ViewWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			String memberId = request.getParameter("memberId");
			List<PortfolioWork> works = new ArrayList<>();
			
			works = mypageService.findAllWork(memberId);
			
//			for(int i = 0; i < works.size(); i++) {
//				System.out.println(i + " " + works.get(i).toString());
//			}
			
			// 4. 응답 : 생성된 work객체 반환
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(works, response.getWriter());
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}

	}


}
