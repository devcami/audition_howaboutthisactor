package ann.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import ann.model.dao.AnnDao;
import ann.model.dto.Ann;
import common.model.dto.Cast;
import common.model.dto.Work;
import common.model.dto.WorkAttachment;
import member.model.dto.Production;

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

	public Ann findByAnnNo(int annNo) {
		Connection conn = getConnection();
		Ann ann = annDao.findByAnnNo(conn, annNo);
		Work work = annDao.findWorkByWorkNo(conn, ann.getWorkNo());
		ann.setWork(work);
		
		List<WorkAttachment> workAttachments = annDao.findAttachmentByWorkNo(conn, ann.getWorkNo());
		if(workAttachments != null && !workAttachments.isEmpty()) {
			work.setAttachments(workAttachments);
		}
		Cast cast = annDao.findCastByWorkNo(conn, ann.getWorkNo());
		if(cast != null) {
			work.setCast(cast);
		}
		
		close(conn);
		return ann;
	}

	public int insertAnn(Ann ann, Work work, Cast cast, Production p) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1. work에 등록
			result = annDao.insertWork(conn, work);
			
			// 2. work No 가져오기
			int workNo = annDao.findCurrentWorkNo(conn);
			work.setWorkNo(workNo);
			
			// 3. work attachment에 등록
			List<WorkAttachment> attachments = work.getAttachments();
			if(attachments != null && !attachments.isEmpty()) {
				for(WorkAttachment attach : attachments) {
					attach.setWorkNo(workNo);
					result = annDao.insertWorkAttachment(conn, attach);
				}
			}
			
			// 4. production(p.memberId) 휴대폰, 이메일 비공개 여부 업데이트
			result = annDao.updateProduction(conn, p);
			
			// 5. cast#setWorkNo 등록
			cast.setWorkNo(workNo);
			
			// 6. cast에 등록
			result = annDao.insertCast(conn, cast);
			
			// 7. ann#setWork, #setWorkNo 등록
			ann.setWorkNo(workNo);
			ann.setWork(work);
			
			// 8. ann 등록
			result = annDao.insertAnn(conn, ann);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public Production findProductionByMemberId(String memberId) {
		Connection conn = getConnection();
		Production p = annDao.findProductionByMemberId(conn, memberId);
		close(conn);
		return p;
	}

	public int deleteAnn(int annNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = annDao.deleteAnn(conn, annNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public WorkAttachment findOneAttachByWorkNo(int waNo) {
		Connection conn = getConnection();
		WorkAttachment attach = annDao.findOneAttachByWorkNo(conn, waNo);
		close(conn);
		return attach;
	}

	public int deleteWorkAttachment(int waNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = annDao.deleteWorkAttachment(conn, waNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int updateAnn(Ann ann, Work work, Cast cast, Production p) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1. work를 수정
			result = annDao.updateWork(conn, work);
			
			// 2. 새 work attachment를 등록
			List<WorkAttachment> attachments = work.getAttachments();
			if(attachments != null && !attachments.isEmpty()) {
				for(WorkAttachment attach : attachments) {
					result = annDao.insertWorkAttachment(conn, attach);
				}
			}
			
			// 3. production(p.memberId) 휴대폰, 이메일 비공개 여부 업데이트
			result = annDao.updateProduction(conn, p);
			
			// 4. cast를 수정
			result = annDao.updateCast(conn, cast);
			
			// 5. ann 수정
			result = annDao.updateAnn(conn, ann);
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}
