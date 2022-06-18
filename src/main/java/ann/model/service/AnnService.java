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
import mypage.model.dao.MypageDao;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.ActorInfoExt;

public class AnnService {
	public static final int NUM_PER_PAGE = 12;
	private AnnDao annDao = new AnnDao();
	private MypageDao mypageDao = new MypageDao();
	
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = annDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public List<Ann> findAll() {
		Connection conn = getConnection();
		List<Ann> list = annDao.findAll(conn);
		close(conn);
		return list;
	}

	public List<Ann> annEndDateSort() {
		Connection conn = getConnection();
		List<Ann> list = annDao.annEndDateSort(conn);
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

	public WorkAttachment findOneAttachByWaNo(int waNo) {
		Connection conn = getConnection();
		WorkAttachment attach = annDao.findOneAttachByWaNo(conn, waNo);
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

	public List<Ann> findByAnnTitle(String searchKeyword) {
		Connection conn = getConnection();
		List<Ann> list = annDao.findByAnnTitle(conn, searchKeyword);
		close(conn);
		return list;
	}

	public int insertAnnReport(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = annDao.insertAnnReport(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int insertAnnApply(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = annDao.insertAnnApply(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<ActorInfoExt> getApplyList(String memberId) {
		Connection conn = getConnection();
		ActorInfo actorInfo = mypageDao.findActorInfo(conn, memberId);
		List<ActorInfoExt> annApplyList = annDao.getApplyList(conn, actorInfo);
		close(conn);
		return annApplyList;
	}

	public int getTotalByTitle(String searchKeyword) {
		Connection conn = getConnection();
		int totalContent = annDao.getTotalByTitle(conn, searchKeyword);
		close(conn);
		return totalContent;
	}

	public List<Ann> detailFinderGender(List<Ann> list, String annGender) {
		Connection conn = getConnection();
		List<Ann> annList = annDao.detailFinderGender(conn, annGender, list);
		close(conn);
		return annList;
	}

	public List<Ann> detailFinderAge(List<Ann> list, String annAge) {
		Connection conn = getConnection();
		List<Ann> annList = annDao.detailFinderAge(conn, annAge, list);
		close(conn);
		return annList;
	}

	public List<Ann> detailFinderHeight(List<Ann> list, String annHeight) {
		Connection conn = getConnection();
		List<Ann> annList = annDao.detailFinderHeight(conn, annHeight, list);
		close(conn);
		return annList;
	}

	public List<Ann> detailFinderBody(List<Ann> list, String annBody) {
		Connection conn = getConnection();
		List<Ann> annList = annDao.detailFinderBody(conn, annBody, list);
		close(conn);
		return annList;
	}

	public List<Ann> findMorePage(Map<String, Integer> param) {
		Connection conn = getConnection();
		List<Ann> list = annDao.findMorePage(conn, param);
		close(conn);
		return list;
	}

	public List<Ann> annPopSort() {
		Connection conn = getConnection();
		List<Ann> list = annDao.annPopSort(conn);
		close(conn);
		return list;
	}

}
