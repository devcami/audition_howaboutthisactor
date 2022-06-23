package ann.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import ann.model.dto.Ann;
import ann.model.service.AnnService;
import common.HelloMvcFileRenamePolicy;
import common.model.dto.Cast;
import common.model.dto.Work;
import common.model.dto.WorkAttachment;
import member.model.dto.Member;
import member.model.dto.Production;

@WebServlet("/ann/annEnroll")
public class AnnEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		Production production = annService.findProductionByMemberId(loginMember.getMemberId());
		request.setAttribute("production", production);
		request.getRequestDispatcher("/WEB-INF/views/ann/annEnroll.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ServletContext application = getServletContext(); 
			
			String webRoot = application.getRealPath("/"); 
			String saveDirectory = webRoot + "upload/ann";
			int maxPostSize = 1024 * 1024 * 10;
			String encoding = "utf-8";
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
			MultipartRequest multiReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 사용자 입력값 처리 (Frm작성 순서대로)
			
			// 1. 작품정보
			String annTitle = multiReq.getParameter("annTitle"); //ann
			String title = multiReq.getParameter("title"); //work
			String workField = multiReq.getParameter("workField"); //work
			String director = multiReq.getParameter("director"); //work
			String production = multiReq.getParameter("production"); //work
			String description = multiReq.getParameter("description"); //work
			String annEndDate_ = multiReq.getParameter("annEndDate"); //ann
			Date annEndDate = Date.valueOf(annEndDate_);
			File attach1 = multiReq.getFile("attach1"); //work
			File attach2 = multiReq.getFile("attach2");
			File attach3 = multiReq.getFile("attach3");
			File attach4 = multiReq.getFile("attach4");
			File attach5 = multiReq.getFile("attach5");
			
			// 2. 배역정보
			String castName = multiReq.getParameter("castName"); //cast
			String castRole = multiReq.getParameter("castRole"); //cast
			String hasTo = multiReq.getParameter("hasTO"); //ann
			String annGender = multiReq.getParameter("annGender"); //ann
			String annAge = multiReq.getParameter("annAge"); //ann
			int annNop = Integer.parseInt(multiReq.getParameter("annNop")); //ann
			String annHeight = multiReq.getParameter("annHeight"); //ann
			String annBody = multiReq.getParameter("annBody"); //ann
			String castContents = multiReq.getParameter("castContents"); //ann
			String annArea = multiReq.getParameter("annArea"); //ann
			String annPay = multiReq.getParameter("annPay"); //ann
			
			// 3. 담당자정보
			String loginMemberId = multiReq.getParameter("loginMemberId"); 
			String isPhoneOpen = multiReq.getParameter("isPhoneOpen"); //production
			String isEmailOpen = multiReq.getParameter("isEmailOpen");
			
			Ann ann = new Ann();
			Cast cast = new Cast();
			Work work = new Work();
			Production p = new Production();
			
			ann.setMemberId(loginMemberId);
			ann.setAnnTitle(annTitle);
			work.setTitle(title);
			work.setWorkField(workField);
			work.setDirector(director);
			work.setProduction(production);
			work.setDescription(description);
			ann.setAnnEndDate(annEndDate);
			
			if(attach1 != null || attach2 != null || attach3 != null || attach4 != null || attach5 != null) {
				List<WorkAttachment> attachments = new ArrayList<>();
				if(attach1 != null)
					attachments.add(getAttachment(multiReq, "attach1"));
				if(attach2 != null)
					attachments.add(getAttachment(multiReq, "attach2"));
				if(attach3 != null)
					attachments.add(getAttachment(multiReq, "attach3"));
				if(attach4 != null)
					attachments.add(getAttachment(multiReq, "attach4"));
				if(attach5 != null)
					attachments.add(getAttachment(multiReq, "attach5"));
				work.setAttachments(attachments);
			}
			
			cast.setCastName(castName);
			cast.setCastRole(castRole);
			ann.setHasTO(hasTo);
			ann.setAnnGender(annGender);
			ann.setAnnAge(annAge);
			ann.setAnnNop(annNop);
			ann.setAnnHeight(annHeight);
			ann.setAnnBody(annBody);
			cast.setCastContents(castContents);
			ann.setAnnArea(annArea);
			ann.setAnnPay(annPay);
			p.setMemberId(loginMemberId);
			p.setIsPhoneOpen(isPhoneOpen);
			p.setIsEmailOpen(isEmailOpen);
			
			System.out.println("----annEnroll----");
			System.out.println("ann = " + ann);
			System.out.println("cast = " + cast);
			System.out.println("work = " + work);
			System.out.println("Production = " + p);
			
			// 업무로직
			int result = annService.insertAnn(ann, work, cast, p);
			
			// 리다이렉트
			
			response.sendRedirect(request.getContextPath() + "/ann/annListAsync");			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private WorkAttachment getAttachment(MultipartRequest multiReq, String name) {
		WorkAttachment attach = new WorkAttachment();
		String originalFilename = multiReq.getOriginalFileName(name); //업로드한 파일명
		String renamedFilename = multiReq.getFilesystemName(name); //저장된 파일명
		attach.setOriginalFilename(originalFilename);
		attach.setRenamedFilename(renamedFilename);
		return attach;
	}
}
