package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
// import javax.servlet.http.Cookie;
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
		request.setCharacterEncoding("utf-8");
		
		// 사용자입력값 처리
		String memberId = request.getParameter("memberId");
		String password = HelloMvcUtils.encrypt(request.getParameter("password"), memberId);
//		String saveId = request.getParameter("saveId"); // "on" | null // saveId 구현해야해애애.....
		System.out.println("memberId@memberLogin = " + memberId);
		System.out.println("password@memberLogin = " + password);
//		System.out.println("saveId@memberLogin = " + saveId);
		
		// 업무로직
		Member member = memberService.findByMemberId(memberId);
		System.out.println("member@memberLogin = " + member);
		
		// session 가져오기
		HttpSession session = request.getSession();
		
		if(member != null && password.equals(member.getPassword())) {
			// 로그인 성공!
			session.setAttribute("loginMember", member);
			
/*			// saveId 쿠키 처리 해야해애애애....
            Cookie cookie = new Cookie("saveId", memberId);
			cookie.setPath(request.getContextPath()); // /app으로 시작하는 경로에 이 쿠키를 사용함.
			if(saveId != null) {
				// max-age설정이 없다면, 세션쿠키로 등록. 브라우져 종료시 폐기
				// max-age설정이 있다면, 영속쿠키로 등록. 지정한 시각에 폐기
				cookie.setMaxAge(7 * 24 * 60 * 60); // 초단위 일주일후 폐기
			}
			else {
				cookie.setMaxAge(0); // 0 즉시삭제
			}
			response.addCookie(cookie); // 응답객체 쿠키추가. Set-Cookie 헤더에 작성	
*/			
		}
		else {
			// 로그인 실패!
			session.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		// 응답처리 : 리다이렉트
		response.sendRedirect(request.getContextPath() + "/");
	} catch(Exception e) {
		// 1. 로깅 및 관리팀 알림.
		e.printStackTrace();
//		errorLogToDiscord(e);
		// 2. 예외던지기 - tomcat에 통보
		throw e;
		}
	}

}

