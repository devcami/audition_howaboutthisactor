package notice.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;
import java.util.Map;


import notice.model.dao.NoticeDao;
import notice.model.dto.Notice;
import notice.model.dto.NoticeExt;

public class NoticeService {


	private NoticeDao noticeDao = new NoticeDao();
	public static final int NUM_PER_PAGE = 12;
	
	public List<NoticeExt> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<NoticeExt> list = noticeDao.findAll(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContents() {
		Connection conn = getConnection();
		int totalContents = noticeDao.getTotalContents(conn);
		close(conn);
		return totalContents;

	}

	/**
	 * Transaction
	 * - all or none
	 * 
	 * 
	 * @param board
	 * @return
	 */
	public int insertNotice(Notice notice) {
		int result = 0;
		Connection conn = getConnection();
		try {
			
			// 1. board에 등록
			result = noticeDao.insertNotice(conn, notice); // pk no값 결정 - seq_board_no.nextval

			// 2. board pk 가져오기
			int no = noticeDao.findCurrentNoticeNo(conn); // seq_board_no.currval
			notice.setNo(no);
			System.out.println("방금 등록된 board.no = " + no);
		
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	public NoticeExt findByNo(int no) {
		Connection conn = getConnection();
		NoticeExt notice = noticeDao.findByNo(conn, no); // board테이블 조회
		close(conn);
		return notice;
	}

	public int updateReadCount(int no) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = noticeDao.updateReadCount(conn, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	public int deleteNotice(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = noticeDao.deleteNotice(conn, no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e; 
		} finally {
			close(conn);
		}
		return result;
	}

	public int updateNotice(NoticeExt notice) {
		int result = 0;
		Connection conn = getConnection();
		try {
			
			// 1. board 수정
			result = noticeDao.updateNotice(conn, notice);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}


}


