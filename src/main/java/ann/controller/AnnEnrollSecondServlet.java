package ann.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ann/annEnrollSecond")
public class AnnEnrollSecondServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/ann/annEnrollSecond.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값
		
		// 업무로직 아직 안함 마지막장에서한번에 처리
		
		// 1번째 장에 적은 내용을 2번째 장에 넘기기 (Ann, Work, WorkAttachment, Cast정보)
	}


}
