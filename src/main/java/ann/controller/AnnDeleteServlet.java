package ann.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ann.model.service.AnnService;
import common.model.dto.WorkAttachment;

@WebServlet("/ann/annDelete")
public class AnnDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnnService annService = new AnnService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int annNo = Integer.parseInt(request.getParameter("annNo"));
		
		//작품 첨부파일 삭제
		List<WorkAttachment> attachments = annService.findByAnnNo(annNo).getWork().getAttachments();
		if(attachments != null && !attachments.isEmpty()) {
			for(WorkAttachment wa : attachments) {
				String saveDirectory = getServletContext().getRealPath("/upload/ann");
				File delFile = new File(saveDirectory, wa.getRenamedFilename());
				if(delFile.exists()) 
					delFile.delete();
			}
		}
		
		//작품 첨부파일 삭제 후 글 삭제
		int result = annService.deleteAnn(annNo);
		
		response.sendRedirect(request.getContextPath() + "/ann/annList");
	}

}
