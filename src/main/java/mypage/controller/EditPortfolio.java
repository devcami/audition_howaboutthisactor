package mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import common.HelloMvcFileRenamePolicy;
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
			
			String saveDirectory = getServletContext().getRealPath("/upload/board");
			int maxPostSize = 1024 * 1024 * 10;
			String encoding = "utf-8";
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
			MultipartRequest multiReq = 
					new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			
//			request.setCharacterEncoding("utf-8");
			
			String memberId = multiReq.getParameter("memberId");
			String name = multiReq.getParameter("Pname");
			String birth = multiReq.getParameter("Pbirth");
			int age = Integer.parseInt(multiReq.getParameter("Page"));
			String company = multiReq.getParameter("company");
			String education = multiReq.getParameter("education");
			double height =  Double.parseDouble(multiReq.getParameter("height"));
			double weight = Double.parseDouble(multiReq.getParameter("weight"));
			String phone = multiReq.getParameter("Pphone"); 
			String email = multiReq.getParameter("Pemail");
			String sns = multiReq.getParameter("Psns");
			String speciality = multiReq.getParameter("Pspeciality");
			
//			System.out.println(memberId);
			System.out.println("이름: " + name);
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
			
			
//			request.setAttribute("img_src", img_src);
//			request.setAttribute("actorInfo", actorInfo);
//			request.setAttribute("portType", "exist");
//			request.getRequestDispatcher("/WEB-INF/views/mypage/viewPortfolio.jsp")
//			.forward(request, response);
		} catch(Exception e) {
			
		}
		
	}

}
