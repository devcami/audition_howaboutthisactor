package mypage.controller;

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
import mypage.model.dto.ActorInfo;
import mypage.model.dto.PortAttachment;
import mypage.model.service.MypageService;

/**
 * Servlet implementation class EditPortfolio
 */
@WebServlet("/mypage/viewPortfolio")
public class EditPortfolio extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MypageService mypageService = new MypageService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String saveDirectory = getServletContext().getRealPath("/upload/portfolio");
			int maxPostSize = 1024 * 1024 * 10;
			String encoding = "utf-8";
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
			MultipartRequest multiReq = 
					new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);


			String memberId = multiReq.getParameter("memberId");
			String name = multiReq.getParameter("Pname");
			String birth = multiReq.getParameter("Pbirth");
			String _age = multiReq.getParameter("Page");
			String company = multiReq.getParameter("company");
			String education = multiReq.getParameter("school");
			String _height =  multiReq.getParameter("height");
			String _weight = multiReq.getParameter("weight");
			String phone = multiReq.getParameter("Pphone"); 
			String email = multiReq.getParameter("Pemail");
			String sns = multiReq.getParameter("Psns");
			String speciality = multiReq.getParameter("Pspeciality");
			int oldAttachNo = Integer.parseInt(multiReq.getParameter("attachNo"));
			
			int newAttachNo = oldAttachNo; 
			
//			int attachNo = Integer.parseInt(_attachNo);
			
			String portType = multiReq.getParameter("portType");
			
			System.out.println("EditPortfolioServlet@portType" + portType);
			System.out.println("EditPortfolioServlet@attachNo(파일 반영 전)" + oldAttachNo);
			
			int age = 0;
			double height = 0;
			double weight = 0;
			
			if(!_age.isEmpty()) {
				 age = Integer.parseInt(_age);
			}
			if(!_height.isEmpty()) {
				height = Double.parseDouble(_height);
			}
			if(!_weight.isEmpty()) {
				weight = Double.parseDouble(_weight);
			}
			
//			System.out.println(memberId);
//			System.out.println("이름: " + name);
//			System.out.println(birth);
//			System.out.println(age);
//			System.out.println(company);
//			System.out.println(education);
//			System.out.println(height);
//			System.out.println(weight);
//			System.out.println(phone);
//			System.out.println(email);
//			System.out.println(sns);
//			System.out.println(speciality);

			ActorInfo actorInfo = new ActorInfo();

			actorInfo.setMemberId(memberId);
			actorInfo.setActorName(name);
			actorInfo.setBirth(birth);
			actorInfo.setAge(age);
			actorInfo.setCompany(company);
			actorInfo.setEducation(education);
			actorInfo.setHeight(height);
			actorInfo.setWeight(weight);
			actorInfo.setPhone(phone);
			actorInfo.setEmail(email);
			actorInfo.setSns(sns);
			actorInfo.setSpeciality(speciality);
			actorInfo.setAttachNo(oldAttachNo);
			
			List<Integer> resultNo = new ArrayList<>();
			
			String _delNo = multiReq.getParameter("delFile");
			
			if(_delNo != null) {
				int delNo = Integer.parseInt(_delNo);
//				System.out.println("삭제할 파일 넘버 = " + delNo);
				PortAttachment pa = mypageService.findOneAttachByPaNo(delNo);
//				System.out.println("삭제할 파일 = " + pa);
				File delFile = new File(saveDirectory, pa.getRenamedFilename());
				if(delFile.exists()) delFile.delete();
				int result = mypageService.deleteWorkAttachmentByNo(delNo);
			}
			
			
			

			File profilePic = multiReq.getFile("profilePic");
			System.out.println("EditPortfolioServlet@profilePic" + profilePic);
			
			if(profilePic != null) {
				PortAttachment attachment = new PortAttachment();	
				String originalFilename = multiReq.getOriginalFileName("profilePic");
				String renamedFilename = multiReq.getFilesystemName("profilePic");
				attachment.setMemberId(memberId);
				attachment.setAttachType("P");
				attachment.setOriginalFilename(originalFilename);
				attachment.setRenamedFilename(renamedFilename);
				
				resultNo = mypageService.insertPortAttachment(attachment, oldAttachNo);
				
				int result = resultNo.get(0);
				newAttachNo = resultNo.get(1);
				
				System.out.println("EditPortfolioServlet@방금 등록된 attachNo = " + newAttachNo);
			
				actorInfo.setAttachNo(newAttachNo);
				actorInfo.setAttachment(attachment);						
			}
			
			System.out.println("EditPortfolioServlet@최종actorInfo = " + actorInfo);

			int result = 0;
			if(portType.equals("exist")) {
				// update 쿼리 실행
				result = mypageService.updatePortfolio(actorInfo);
				
			} else { // portType이 New일 경우
				// insert 쿼리 실행
				result = mypageService.enrollPortfolio(actorInfo);
			}
			
			String fileName = mypageService.getRenamedFilename(newAttachNo);
			String img_src = "";
			if(newAttachNo == 130) {
				img_src = request.getContextPath() + "/images/default.png"; 
			}
			else {
				img_src = request.getContextPath() + "/upload/portfolio/" + fileName;	
			}

			request.setAttribute("img_src", img_src);
			request.setAttribute("actorInfo", actorInfo);
			request.setAttribute("portType", "exist");
			request.getRequestDispatcher("/WEB-INF/views/mypage/viewPortfolio.jsp")
			.forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
