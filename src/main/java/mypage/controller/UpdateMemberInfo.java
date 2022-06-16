package mypage.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.HelloMvcUtils;
import member.model.dto.Member;
import member.model.service.MemberService;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class UpdateMemberInfo
 */
@WebServlet("/mypage/updateMemberInfo")
public class UpdateMemberInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			request.setCharacterEncoding("utf-8");   
			
			
			String memberId = request.getParameter("memberId");
			String name = request.getParameter("memberName");
			String email = request.getParameter("memberEmail");
			String gender = request.getParameter("gender");
			String type = request.getParameter("type");
			String newpassword = HelloMvcUtils.encrypt(request.getParameter("pw"), memberId);
			String phone = request.getParameter("phone");
			
			String _birth = request.getParameter("birth");
			Date birth = null;
			if(_birth != null && !"".equals(_birth))
				birth = Date.valueOf(_birth);	
			
			String[] _genre = request.getParameterValues("genre");
			String genre = "";
			if(_genre != null)
				genre = String.join(",", _genre);

			Member member = 
					new Member(memberId, newpassword, name, email, null, phone, gender, birth, null, genre);

			System.out.println("member@MemberUpdateServlet = " + member);
			
			// 3. 업무로직 (service에 updateMember요청)
			int result = mypageService.updateMember(member);
			String msg = "회원정보를 성공적으로 수정했습니다.";
			
			
			// 세션 정보 갱신
			Member updateMember = memberService.findByMemberId(memberId);

			HttpSession session = request.getSession();
			session.setAttribute("loginMember", updateMember);
			session.setAttribute("result", msg);
			
			
			// 4. redirect - msg는 session에 저장
			request.getSession().setAttribute("msg", msg);  // redirect 후에 꺼내서 출력이 됨.
			response.sendRedirect(request.getContextPath() + "/mypage/updateMember?memberId=" + memberId);
			// 위와 같이 하면 index페이지가 아니라 현재 회원정보페이지로 redirect 되는 것.
			
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

}
