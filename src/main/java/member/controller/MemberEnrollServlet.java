package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.HelloMvcUtils;
import member.model.dto.Member;
import member.model.dto.MemberRole;
import member.model.service.MemberService;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * 회원가입폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
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
		// 단방향 암호화 처리
		String password = HelloMvcUtils.encrypt(request.getParameter("password"), memberId);
		String memberName = request.getParameter("memberName");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		String _birthday = request.getParameter("birthday");
		System.out.println(_birthday);
		Date birthday = null;
		if(_birthday != null && !"".equals(_birthday))
			birthday = Date.valueOf(_birthday);
		
		String[] _genre = request.getParameterValues("genre");
		String genre = null;
		if(_genre != null)
			genre = String.join(",", _genre);
		
/*		// 추후 확인 요망(회원유형)
		String[] _type = request.getParameterValues("type");
		String type = null;
		if(_type !=null)
			type = String.join(",", _type);
*/		
	
 		Member member = new Member(
				memberId, password, memberName, email, MemberRole.P, 
				phone, gender, birthday, null, genre
			);
 		
		System.out.println("member@memberEnroll = " + member);
		
		// 3. 업무로직 (db insert) 
		int result = memberService.insertMember(member);
	

		String msg = "성공적으로 회원가입했습니다.";
		
		// 4. 리다이렉트 (DML처리인 경우 url을 변경해서 새로고침오류를 방지한다.)
		// 사용자 경고창 처리
		// 성공적으로 회원가입했습니다. | 회원가입 실패했습니다. 
		request
			.getSession()
			.setAttribute("msg", msg);
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
