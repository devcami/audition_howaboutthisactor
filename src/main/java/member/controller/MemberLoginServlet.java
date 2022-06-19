package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.HelloMvcUtils;
import member.model.dto.Member;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberLoginServlet
 */
@WebServlet("/member/memberLogin")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MemberService memberService = new MemberService();
	
	/**
	 * 로그인폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {	
			
			// 사용자입력값 처리
			String memberId = request.getParameter("memberId");
			String password = HelloMvcUtils.encrypt(request.getParameter("password"), memberId);
			String saveId = request.getParameter("saveId"); 
			
			// 업무로직
			Member member = memberService.findByMemberId(memberId);
			HttpSession session = request.getSession();
			
			if(member != null && password.equals(member.getPassword())) {
				session.setAttribute("loginMember", member);
				
	            Cookie cookie = new Cookie("saveId", memberId);
				cookie.setPath(request.getContextPath()); 
				if(saveId != null) {
					cookie.setMaxAge(7 * 24 * 60 * 60); 
				}
				else {
					cookie.setMaxAge(0); 
				}
				response.addCookie(cookie); 
			}
			else {
				session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			}
			
			// 응답처리 : 리다이렉트
			response.sendRedirect(request.getContextPath() + "/");
//			String Referer = request.getHeader("Referer"); // 절대 주소값 http://localhost:9090/mvc/board/boardList
//			response.sendRedirect(Referer); 
			
		} catch(Exception e) {
		e.printStackTrace();
		throw e;
		}
	}

}

