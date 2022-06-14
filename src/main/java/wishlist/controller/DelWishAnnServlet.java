package wishlist.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import wishlist.model.dto.WishListAnn;
import wishlist.model.service.WishListService;

@WebServlet("/ann/delWishAnn")
public class DelWishAnnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private WishListService wishListService = new WishListService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int annNo = Integer.parseInt(request.getParameter("annNo"));
			String memberId = request.getParameter("memberId");
			int result = wishListService.delWishlistAnn(annNo);
			response.sendRedirect(request.getContextPath()+"/ann/annView?annNo="+annNo+"&memberId="+memberId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}

