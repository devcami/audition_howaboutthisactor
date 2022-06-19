package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.HelloMvcFileRenamePolicy;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWorkExt;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class EnrollWorkServlet
 */
@WebServlet("/mypage/enrollwork")
public class EnrollWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. MultipartRequest객체 생성(파일업로드 완료) 
			
			// a. 파일저장경로
			// C:\\Workspaces\\Servlet_JSP_workspace\\hello-mvc\\src\\main\\webapp\\upload\\portfolio
			String saveDirectory = getServletContext().getRealPath("/upload/portfolio");
			
			// b. 최대파일크기 10MB
			int maxPostSize = 1024 * 1024 * 10;
			
			// c. 인코딩
			String encoding = "utf-8";
			
			// d. 파일명 재지정 정책 객체
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
			MultipartRequest multiReq = 
					new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 2. 사용자 입력값 처리
			String title = multiReq.getParameter("title");
			String memberId = multiReq.getParameter("member");
			String myrole = multiReq.getParameter("role");
			String period = multiReq.getParameter("period");
			String videolink = multiReq.getParameter("videolink");
			
			System.out.println("title = " + title + " member = " + memberId + " myrole = " + myrole + " period = " + period + " videolink = " + videolink);
			
			PortfolioWorkExt work = new PortfolioWorkExt();
			work.setTitle(title);
			work.setMemberId(memberId);
			work.setMyrole(myrole);
			work.setPeriod(period);
			work.setVideolink(videolink);
			
			File workpic = multiReq.getFile("workpic");
			File pic2 = multiReq.getFile("pic2");
			File pic3 = multiReq.getFile("pic3");
			File pic4 = multiReq.getFile("pic4");
			

			if(workpic != null) {
				PortAttachment attachment = new PortAttachment();
				
				String originalFilename = multiReq.getOriginalFileName("workpic");
				String renamedFilename = multiReq.getFilesystemName("workpic");
				attachment.setMemberId(memberId);
				attachment.setAttachType("W");
				attachment.setOriginalFilename(originalFilename);
				attachment.setRenamedFilename(renamedFilename);
				
				work.setAttachment(attachment);
				
//				System.out.println(attachment.getOriginalFilename());
//				System.out.println(attachment.getRenamedFilename());
				// test
			}
			
			if(pic2 != null) {
				PortAttachment attach = new PortAttachment();
				work.setAttach1(handlePortAttachment(multiReq, "pic2", memberId, attach));
			}
			if(pic3 != null) {
				PortAttachment attach = new PortAttachment();
				work.setAttach2(handlePortAttachment(multiReq, "pic3", memberId, attach));
			}
			if(pic4 != null) {
				PortAttachment attach = new PortAttachment();
				work.setAttach3(handlePortAttachment(multiReq, "pic4", memberId, attach));
			}
			
			// 3. 업무로직 work에 추가
			List<Integer> resultNo = mypageService.insertPortWork(work);
			
			int result = resultNo.get(0);
			int no = resultNo.get(1);
			work.setNo(no);
			
			
			// 4. 응답 : 생성된 work객체 반환
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(work, response.getWriter());
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	private PortAttachment handlePortAttachment(MultipartRequest multiReq, String file, String memberId, PortAttachment attach) throws SQLException{
		
		String originalFilename = multiReq.getOriginalFileName(file);
		String renamedFilename = multiReq.getFilesystemName(file);
		attach.setMemberId(memberId);
		attach.setAttachType("WW");
		attach.setOriginalFilename(originalFilename);
		attach.setRenamedFilename(renamedFilename);
		
		return attach;
	}

}
