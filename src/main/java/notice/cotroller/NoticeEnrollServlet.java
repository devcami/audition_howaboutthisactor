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
			// 2. MultipartRequest객체 생성
			// b. 파일저장경로
			// "D:\\Workspaces\\webserver_workspace\\hello-mvc\\src\\main\\webapp\\upload\\board"
//			ServletContext application = getServletContext();
//			String webRoot = application.getRealPath("/");
//			// File.separator 운영체제별 경로 구분자 (window: \, mac/linux: /)
//			String saveDirectory = webRoot + "upload" + File.separator + "board";
			String saveDirectory = getServletContext().getRealPath("/upload/notice");
			System.out.println("saveDirectory = " + saveDirectory);
			// c. 최대파일크기 10MB 
			int maxPostSize = 1024 * 1024 * 10;
			// d. 인코딩
			String encoding = "utf-8";
			// e. 파일명 재지정 정책 객체
			// DefaultFileRenamePolicy 파일명 중복시 numbering처리함.
//			FileRenamePolicy policy = new DefaultFileRenamePolicy();
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
			MultipartRequest multiReq = 
					new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 3. 사용자입력값 처리
			// dto 객체 생성
			String title = multiReq.getParameter("title");
			String memberId = multiReq.getParameter("memberId");
			String content = multiReq.getParameter("content");
			NoticeExt notice = new NoticeExt();
			notice.setTitle(title);
			notice.setMemberId(memberId);
			notice.setContent(content);
			
			File upFile1 = multiReq.getFile("upFile1");
			File upFile2 = multiReq.getFile("upFile2");
			
			
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



