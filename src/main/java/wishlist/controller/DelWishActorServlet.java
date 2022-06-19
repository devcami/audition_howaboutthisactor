package wishlist.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import wishlist.model.dto.WishListActor;
import wishlist.model.service.WishListService;

@WebServlet("/actor/delWishActor")
public class DelWishActorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WishListService wishListService = new WishListService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int actorNo = Integer.parseInt(request.getParameter("actorNo"));
			String memberId = request.getParameter("memberId");
			WishListActor wishListActor = new WishListActor();
			wishListActor.setActorNo(actorNo);
			wishListActor.setMemberId(memberId);
			int result = wishListService.delWishlistActor(wishListActor);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(wishListActor, response.getWriter());
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
