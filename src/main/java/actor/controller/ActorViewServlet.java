package actor.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import actor.model.service.ActorService;

/**
 * Servlet implementation class ActorView
 */
@WebServlet("/actor/actorView")
public class ActorViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActorService actorService = new ActorService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//3.view단 위임
		
		request.getRequestDispatcher("/WEB-INF/views/actor/actorView.jsp").forward(request, response);
	   }
		
	
	
	
	
	
	
	
	
	
	}

