package notice.cotroller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import board.model.dto.Attachment;
import common.HelloMvcFileRenamePolicy;
import notice.model.dto.NoticeExt;
import notice.model.service.NoticeService;

/**
 * Servlet implementation class BoardUpdateServlet
 */
@WebServlet("/notice/noticeUpdate")
public class NoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();
	/**
	 * 수정폼 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.사용자입력값 처리
		int no = Integer.parseInt(request.getParameter("no")); // 게시판 넘버
		
		// 2.업무로직
		NoticeExt notice = noticeService.findByNo(no);
		
		// 3.view단처리
		request.setAttribute("board", notice);
		request.getRequestDispatcher("/WEB-INF/views/board/boardUpdate.jsp")
			.forward(request, response);
	}

	/**
	 * DB 수정 요청
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
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 2. MultipartRequest객체 생성 - 파일저장완료
		String saveDirectory = getServletContext().getRealPath("/upload/notice");
		int maxPostSize = 1024 * 1024 * 10;
		String encoding = "utf-8";
		FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
		MultipartRequest multiReq = 
				new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		// 3. 사용자입력값 처리 - HttpServletRequest가 아닌 MultipartRequest에서 값을 가져오기
		// update board set title = ?, content = ? where no = ?
		int no = Integer.parseInt(multiReq.getParameter("no"));
		String title = multiReq.getParameter("title");
		String memberId = multiReq.getParameter("memberId");
		String content = multiReq.getParameter("content");
		
		NoticeExt notice = new NoticeExt();
		notice.setNo(no);
		notice.setTitle(title);
		notice.setMemberId(memberId);
		notice.setContent(content);
		
		// 4. 업무로직 - 
		// db board(update), attachment(insert) 레코드 등록
		int result = noticeService.updateNotice(notice);
		// 첨부파일 삭제 처리
	
		// 5. redirect
		response.sendRedirect(request.getContextPath() + "/notice/noticeView?no=" + no);
		
	}

}