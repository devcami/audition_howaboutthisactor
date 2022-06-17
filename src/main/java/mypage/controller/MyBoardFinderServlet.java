package mypage.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
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

import board.model.dto.Board;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class MyAnnFinder
 */
@WebServlet("/mypage/myBoardFinder")
public class MyBoardFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			
			
			String searchKeyword = request.getParameter("searchKeyword");
			String memberId = request.getParameter("memberId");
			
			System.out.println(searchKeyword);
			System.out.println(memberId);
			
			List<Board> list = mypageService.findMyBoardByTitle(searchKeyword, memberId);
//			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			
//			List<String> dateList = new ArrayList<>();
//			
//			for(int i = 0; i < list.size(); i++) {
//				String strDate = transFormat.format(list.get(i).getRegDate());
//				dateList.add(strDate);
//			}
//			
//			Map<Board, String> resultList = new HashMap<>(); 
//			
//			for(int i = 0; i < list.size(); i++) {
//				resultList.put(list.get(i), dateList.get(i));
//			}
			
//			request.setAttribute("dateList", dateList);
			request.setAttribute("list", list);
			request.setAttribute("searchKeyword", searchKeyword);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(list, response.getWriter());
//			new Gson().toJson(resultList, response.getWriter());
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
