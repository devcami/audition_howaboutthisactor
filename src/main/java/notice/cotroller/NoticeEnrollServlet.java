package notice.cotroller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.HelloMvcFileRenamePolicy;
import notice.model.dto.NoticeExt;
import notice.model.service.NoticeService;

/**
 * Servlet implementation class BoardEnrollServlet
 */
@WebServlet("/notice/noticeEnroll")
public class NoticeEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();


	/**
	 * 게시글쓰기 폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/notice/noticeEnroll.jsp")
			.forward(request, response);
	}

	/**
	 * 게시글 등록 요청
	 * - 게시글 등록시 /board/boardList 리다이렉트
	 * 
	 * 파일업로드 절차
	 * - 1. 제출폼 enctype="multipart/form-data"
	 * - 2. MultipartRequest객체 생성 - 파일저장완료
	 * 		a. HttpServletRequest
	 * 		b. saveDirectory
	 * 		c. maxPostSize 최대업로드크기
	 * 		d. encoding
	 * 		e. FileRenamePolicy객체 
	 * - 3. 사용자입력값 처리 - HttpServletRequest가 아닌 MultipartRequest에서 값을 가져오기
	 * - 4. 업무로직 - db board, attachment 레코드 등록
	 * - 5. redirect
	 * 
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			  request.setCharacterEncoding("utf-8");
		
			// 3. 사용자입력값 처리
			// dto 객체 생성
			String title = request.getParameter("title");
			String memberId = request.getParameter("memberId");
			String content = request.getParameter("content");
			NoticeExt notice = new NoticeExt();
			
			notice.setTitle(title);
			notice.setMemberId(memberId);
			notice.setContent(content);
			
					
			System.out.println("notice = " + notice);
			// 4. 업무로직
			
			int result = noticeService.insertNotice(notice);
			// 5. redirect
			response.sendRedirect(request.getContextPath() + "/notice/noticeView?no=" + notice.getNo());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}



