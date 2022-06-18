package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dto.Member;
import member.model.service.MemberService;

@WebServlet("/member/kakaoLogin")
public class KakaoLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			Member member = memberService.findByMemberId(memberId);
			HttpSession session = request.getSession();
			if(member != null) {
				session.setAttribute("loginMember", member);
			}
			String Referer = request.getHeader("Referer");
			response.sendRedirect(Referer);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
