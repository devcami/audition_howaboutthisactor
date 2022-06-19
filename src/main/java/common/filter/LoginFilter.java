package common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dto.Member;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter({ 
	"/ann/annEnroll",
	"/ann/annView",
	"/ann/annUpdate",
	"/ann/annApply",
	"/ann/annReport",
	"/ann/annDelete",
	"/member/memberView", 
	"/actor/actorView",
	"/mypage/addWork",
	"/mypage/ckpw_update", 
	"/mypage/ckpw_delete",
	"/mypage/Dwishlist",
	"/mypage/memberlist",
	"/mypage/myann",
	"/mypage/myboard",
	"/mypage/Papplylist",
	"/mypage/Pwishlist",
	"/mypage/reportlist",
	"/mypage/viewPortfolio",
	"/mypage/enrollPortfolio",
	"/mypage/editPortfolio",
	"/mypage/infoupdate",
	"/board/boardEnroll",
	"/board/boardUpdate",
	"/board/boardDelete",
	"/board/boardList"
	
})
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest) request; 
		HttpServletResponse httpRes = (HttpServletResponse) response; 
		
		// 로그인여부 검사
		HttpSession session = httpReq.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		if(loginMember == null) {
			session.setAttribute("msg", "로그인 후 사용가능합니다.");
			httpRes.sendRedirect(httpReq.getContextPath() + "/member/memberLogin");
			return; // 조기리턴
		}
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
