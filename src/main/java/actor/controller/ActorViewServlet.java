package actor.controller;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import actor.model.dto.Actor;
import actor.model.service.ActorService;
import ann.model.dto.Ann;
import member.model.dto.Member;
import member.model.dto.MemberRole;
import member.model.dto.Production;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;
import mypage.model.service.MypageService;
import wishlist.model.dto.WishListAnn;
import wishlist.model.service.WishListService;

/**
 * Servlet implementation class ActorView
 */
@WebServlet("/actor/actorView")
public class ActorViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActorService actorService = new ActorService();
	private WishListService wishListService = new WishListService();
	private MypageService mypageService = new MypageService();
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int actorNo = Integer.parseInt(request.getParameter("actorNo"));
			
			ActorInfo actorInfo = actorService.detailActorInfo(actorNo);
	       
	   
				
			//3.view 단 위임	
			request.setAttribute("actorInfo", actorInfo);
			request.getRequestDispatcher("/WEB-INF/views/actor/actorView.jsp").forward(request, response);
				
			
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}
}

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//3.view단 위임
	
	
	
	
	
	
	
	
	
	
	

