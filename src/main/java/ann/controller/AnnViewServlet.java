package ann.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ann.model.dto.Ann;
import ann.model.service.AnnService;
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
 * Servlet implementation class AnnViewServlet
 */
@WebServlet("/ann/annView")
public class AnnViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();
	private WishListService wishListService = new WishListService();
	private MypageService mypageService = new MypageService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int annNo = Integer.parseInt(request.getParameter("annNo"));
			
			// 게시글 조회
			Ann ann = annService.findByAnnNo(annNo);
			Production p = annService.findProductionByMemberId(ann.getMemberId());
			
			// loginMember의 wishList가져오기
			HttpSession session = request.getSession();
			Member loginMember = (Member) session.getAttribute("loginMember");
			String memberId = loginMember.getMemberId();
			List <WishListAnn> wishlistAnn = wishListService.annWishlistbyMemberId(memberId);
			
			// loginMember의 멤버롤에 따라 정보 내보내기
			if(loginMember.getMemberRole() == MemberRole.P) {
				List<PortAttachment> allAttachList = mypageService.findAllAttachmentByMemberId(memberId);
				PortAttachment profile  = null;
				List<PortAttachment> workAttachList = new ArrayList<>();
				for(PortAttachment pa : allAttachList) {
					if(pa.getAttachType().equals("P"))
						profile = pa;
					else if(pa.getAttachType().equals("W")){
						workAttachList.add(pa);
					}
				}
				ActorInfo actorInfo = mypageService.findActorInfo(memberId);
				actorInfo.setAttachment(profile);
				
				List<PortfolioWork> pList = mypageService.findAllWork(memberId);
				
				request.setAttribute("actorInfo", actorInfo);
				request.setAttribute("profile", profile);
				request.setAttribute("pList", pList);
				
			}
			
			// XSS공격(Cross-site Scripting공격) 대비 변환 : 개행처리 <br> 이전에 나와야됨!
			ann.setAnnTitle(ann.getAnnTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			
			// 3. view단 위임
			request.setAttribute("ann", ann);
			request.setAttribute("production", p);
			request.setAttribute("wishlistAnn", wishlistAnn);
			request.getRequestDispatcher("/WEB-INF/views/ann/annView.jsp").forward(request, response);
				
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
