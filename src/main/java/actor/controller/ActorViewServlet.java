package actor.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import actor.model.service.ActorService;
import member.model.dto.Member;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;
import mypage.model.service.MypageService;
import wishlist.model.dto.WishListActor;
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
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
         int actorNo = Integer.parseInt(request.getParameter("actorNo"));
         ActorInfo actorInfo = actorService.getActorByActorNo(actorNo);
         String memberId = actorInfo.getMemberId();
         
         // loginMember의 wishList가져오기
         HttpSession session = request.getSession();
         Member loginMember = (Member) session.getAttribute("loginMember");
         String loginId = loginMember.getMemberId();
         List <WishListActor> wishlistActor = wishListService.actorWishlistbyMemberId(loginId);
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
         actorInfo.setAttachment(profile);
         int attachNo = actorInfo.getAttachNo();
         
         List<PortfolioWork> pList = mypageService.findAllWork(memberId);
         
         request.setAttribute("actorInfo", actorInfo);
         request.setAttribute("profile", profile);
         request.setAttribute("pList", pList);
         request.setAttribute("wishlistActor", wishlistActor);
         request.setAttribute("memberId", memberId);
         request.setAttribute("loginId", loginId);
         request.setAttribute("attachNo", attachNo);
            
         request.getRequestDispatcher("/WEB-INF/views/actor/actorView.jsp").forward(request, response);
      } catch (Exception e) {
         e.printStackTrace();
         throw e;
      }
   
   }
}