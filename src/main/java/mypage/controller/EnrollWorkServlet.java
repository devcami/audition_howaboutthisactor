package mypage.controller;

import java.io.File;
import java.io.IOException;
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
import mypage.model.dto.PortfolioWork;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class EnrollWorkServlet
 */
@WebServlet("/mypage/enrollwork")
public class EnrollWorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		PortfolioWork work = new PortfolioWork();
		work.setTitle(title);
		work.setMemberId(memberId);
		work.setMyrole(myrole);
		work.setPeriod(period);
		work.setVideolink(videolink);
		
		File workpic = multiReq.getFile("workpic");
		if(workpic != null) {
			PortAttachment attachment = new PortAttachment();
			
			String originalFilename = multiReq.getOriginalFileName("workpic");
			String renamedFilename = multiReq.getFilesystemName("workpic");
			attachment.setMemberId(memberId);
			attachment.setAttachType("W");
			attachment.setOriginalFilename(originalFilename);
			attachment.setRenamedFilename(renamedFilename);
			
			work.setAttachment(attachment);
			
			System.out.println(attachment.getOriginalFilename());
			System.out.println(attachment.getRenamedFilename());
			// test
		}
		
		
		// 3. 업무로직 work에 추가
		List<Integer> resultNo = mypageService.insertPortWork(work);
		
		int result = resultNo.get(0);
		int no = resultNo.get(1);
		work.setNo(no);
		
//		System.out.println("방금 등록된 게시물의 no는?? = " + no);
		
		// 4. 응답 : 생성된 work객체 반환
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(work, response.getWriter());
		
	}

}
