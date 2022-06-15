package mypage.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mypage.model.service.MypageService;

/**
 * Servlet implementation class DeleteMemberServlet
 */
@WebServlet("/mypage/deleteMember")
public class DeleteMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//1. 사용자 입력값 처리
			String memberId = request.getParameter("memberId");
			
			//2. 서비스로직호출
			int result = mypageService.deleteMember(memberId);
			
			// 탈퇴후 처리 - 세션폐기, 쿠키폐기
			// 쿠키폐기
			Cookie cookie = new Cookie("saveId", memberId);
			cookie.setPath(request.getContextPath());
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			
			// 모든 세션속성 제거 (session.invalidate() 대신)
			HttpSession session = request.getSession();
			Enumeration<String> names = session.getAttributeNames();  // 속성명만 불러온다.
			while(names.hasMoreElements()) { // 하나씩 순회
				String name = names.nextElement();
				session.removeAttribute(name);
			}
			
			//3. 리다이렉트 처리
			session.setAttribute("msg", "탈퇴가 성공적으로 처리되었습니다. 감사합니다.");
			response.sendRedirect(request.getContextPath() + "/member/logout");

			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
}
