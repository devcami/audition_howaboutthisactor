package ann.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import ann.model.dao.AnnDao;
import ann.model.dto.Ann;
import ann.model.dto.AnnExt;
import common.model.dto.Cast;
import common.model.dto.Work;
import common.model.dto.WorkAttachment;

public class AnnService {
	public static final int NUM_PER_PAGE = 12;
	private AnnDao annDao = new AnnDao();
	
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = annDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public List<Ann> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = annDao.findAll(conn, param);
		close(conn);
		return list;
	}

	public List<Ann> annEndDateSort(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = annDao.annEndDateSort(conn, param);
		close(conn);
		return list;
	}

	public AnnExt findByAnnNo(int annNo) {
		Connection conn = getConnection();
		AnnExt ann = annDao.findByAnnNo(conn, annNo);
		Work work = annDao.findWorkByWorkNo(conn, ann.getWorkNo());
		ann.setWork(work);
		
		List<WorkAttachment> workAttachments = annDao.findAttachmentByWorkNo(conn, ann.getWorkNo());
		if(workAttachments != null && !workAttachments.isEmpty()) {
			work.setAttachments(workAttachments);
			for(WorkAttachment wa : workAttachments) {
				System.out.println("WorkAttachment : " + wa);
			}
		}
		Cast cast = annDao.findCastByWorkNo(conn, ann.getWorkNo());
		if(cast != null) {
			work.setCast(cast);
			System.out.println("Cast : " + cast);
		}
		
		close(conn);
		return ann;
	}
}
