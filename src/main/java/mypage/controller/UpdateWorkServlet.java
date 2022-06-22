package mypage.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

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
 * Servlet implementation class UpdateWorkServlet
 */
@WebServlet("/mypage/updateWork")
public class UpdateWorkServlet extends HttpServlet {
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
			String memberId = multiReq.getParameter("memberId");
			String myrole = multiReq.getParameter("role");
			String period = multiReq.getParameter("period");
			String videolink = multiReq.getParameter("videolink");
			String bosspic = multiReq.getParameter("Obosspic");
			
			System.out.println("Obosspic = " + bosspic);
			
			// 경력번호
			int workNo = Integer.parseInt(multiReq.getParameter("workNo"));
			System.out.println("workNo = " + workNo + " title = " + title + " member = " + memberId + " myrole = " + myrole + " period = " + period + " videolink = " + videolink);
			
			PortfolioWorkExt work = new PortfolioWorkExt();
			
			work.setNo(workNo);
			work.setTitle(title);
			work.setMemberId(memberId);
			work.setMyrole(myrole);
			work.setPeriod(period);
			work.setVideolink(videolink);
			
			// 파일 삭제
			String[] delFiles = multiReq.getParameterValues("delFile");
			if(delFiles != null) {
				for(String temp : delFiles) {
					int paNo = Integer.parseInt(temp);
					System.out.println(paNo);
					PortAttachment pa = mypageService.findOneAttachByPaNo(paNo);
					System.out.println(pa);
					File delFile = new File(saveDirectory, pa.getRenamedFilename());
					if(delFile.exists()) delFile.delete();
					int result = mypageService.deleteWorkAttachmentByNo(paNo);
				}
			}
			
			File workpic = multiReq.getFile("workpic");
			File pic1 = multiReq.getFile("pic1");
			File pic2 = multiReq.getFile("pic2");
			File pic3 = multiReq.getFile("pic3");
			
			if(workpic != null) {
				
				PortAttachment attachment = new PortAttachment();
				
				String originalFilename = multiReq.getOriginalFileName("workpic");
				String renamedFilename = multiReq.getFilesystemName("workpic");
				attachment.setNo(workNo);
				attachment.setMemberId(memberId);
				attachment.setAttachType("W");
				attachment.setOriginalFilename(originalFilename);
				attachment.setRenamedFilename(renamedFilename);
				
				work.setAttachment(attachment);
			} 
			else {
				PortAttachment attachment = mypageService.getBossWorkAttach(memberId,workNo);
				work.setAttachment(attachment);
				attachment.setNo(workNo);
				System.out.println("여기=" + work.getAttachment());
			}
			
			
			if(pic1 != null) {
				PortAttachment attach = new PortAttachment();
				work.setAttach1(handlePortAttachment(multiReq, "pic1", memberId, attach, workNo));
			}
			if(pic2 != null) {
				PortAttachment attach = new PortAttachment();
				work.setAttach2(handlePortAttachment(multiReq, "pic2", memberId, attach, workNo));
			}
			if(pic3 != null) {
				PortAttachment attach = new PortAttachment();
				work.setAttach3(handlePortAttachment(multiReq, "pic3", memberId, attach, workNo));
			}
			
			// 3. 업무로직 work에 추가
			int reulst = mypageService.updatePortWork(work);

			
			// 4. 응답 : 생성된 work객체 반환
			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(work, response.getWriter());
		
		} catch(Exception e) {
			e.printStackTrace();
		}

		
	}
	
	private PortAttachment handlePortAttachment(MultipartRequest multiReq, String file, String memberId, PortAttachment attach, int workNo) throws SQLException{
		
		String originalFilename = multiReq.getOriginalFileName(file);
		String renamedFilename = multiReq.getFilesystemName(file);
		attach.setNo(workNo);
		attach.setMemberId(memberId);
		attach.setAttachType("WW");
		attach.setOriginalFilename(originalFilename);
		attach.setRenamedFilename(renamedFilename);
		
		return attach;
	}

}
