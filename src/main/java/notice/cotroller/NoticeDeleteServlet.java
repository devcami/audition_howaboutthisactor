package notice.cotroller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import notice.model.dto.Attachment;
import notice.model.service.NoticeService;

/**
 * Servlet implementation class NoticeDeleteServlet
 */
@WebServlet("/notice/noticeDelete")
public class NoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1.사용자입력처리
			int no = Integer.parseInt(request.getParameter("no"));

			// 2.업무로직
			// 첨부파일 존재시 삭제
			List<Attachment> attachments = noticeService.findByNo(no).getAttachments();
			if(attachments != null && !attachments.isEmpty())
				for(Attachment attach : attachments) {
					String saveDirectory = getServletContext().getRealPath("/upload/notice");
					File delFile = new File(saveDirectory, attach.getRenamedFilename());
					if(delFile.exists()) {
						delFile.delete();
						System.out.println("> " + attach.getRenamedFilename() + "파일 삭제!");						
					}
				}
					
			
			// board 레코드(행) 삭제 (attachment는 on delete cascade에 의해 자동으로 제거된다.)
			int result = noticeService.deleteNotice(no);
			
			// 3. redirect : /mvc/board/boardList로 이동
			request.getSession().setAttribute("msg", "게시글을 삭제했습니다.");
			response.sendRedirect(request.getContextPath() + "/notice/noticeList");

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

}
