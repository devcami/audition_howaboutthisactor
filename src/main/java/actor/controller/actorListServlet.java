package actor.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.dto.Ann;

/**
 * Servlet implementation class actorView
 */
@WebServlet("/actorListServlet")
public class actorListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchKeyword = request.getParameter("searchKeyword");
				request.setAttribute("searchKeyword", searchKeyword);
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/actor/actorList.jsp");
		reqDispatcher.forward(request, response);			
		
	}
	
	

	}

	
	

