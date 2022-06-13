package ann.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import ann.model.service.AnnService;
import common.HelloMvcFileRenamePolicy;

@WebServlet("/ann/annEnroll")
public class AnnEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/ann/annEnroll.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			ServletContext application = getServletContext(); 
			
			String webRoot = application.getRealPath("/"); 
			String saveDirectory = webRoot + "upload/board";
			int maxPostSize = 1024 * 1024 * 10;
			String encoding = "utf-8";
			FileRenamePolicy policy = new HelloMvcFileRenamePolicy();
			
			
			// 사용자 입력값 처리
			
			response.sendRedirect(request.getContextPath() + "/ann/annList");			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
