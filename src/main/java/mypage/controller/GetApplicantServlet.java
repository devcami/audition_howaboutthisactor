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

import mypage.model.dto.ActorInfo;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class GetApplicantServlet
 */
@WebServlet("/mypage/getApplicant")
public class GetApplicantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String annNo = request.getParameter("annNo");
//			System.out.println("GetApplicantServlet@annNo = " + annNo);

			
			List<ActorInfo> actorList = mypageService.findApplicantActor(annNo);	
//			System.out.println("actorList.size() = " + actorList.size());

			
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(actorList, response.getWriter());
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
	}

}
