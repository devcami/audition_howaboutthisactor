package wishlist.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import wishlist.model.dto.WishListAnn;
import wishlist.model.service.WishListService;

@WebServlet("/ann/addWishAnn")
public class AddWishAnnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WishListService wishListService = new WishListService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int annNo = Integer.parseInt(request.getParameter("annNo"));
			String memberId = request.getParameter("memberId");
			WishListAnn wishListAnn = new WishListAnn();
			wishListAnn.setAnnNo(annNo);
			wishListAnn.setMemberId(memberId);
			int result = wishListService.addWishlistAnn(wishListAnn);
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(wishListAnn, response.getWriter());
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
