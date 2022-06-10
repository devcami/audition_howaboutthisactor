package mypage.model.service;
import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;

import mypage.model.dao.MypageDao;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;

public class MypageService {
	
	private MypageDao mypageDao = new MypageDao();

	public int insertPortWork(PortfolioWork work) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			// 1. portfolio_work에 등록
			result = mypageDao.insertPortWork(conn, work); // pk no값 결정 - seq_board_no
			
			// 2. portfolio_work pk 가져오기
			int no = mypageDao.findCurrentWorkNo(conn); // seq_board_no.currval
			System.out.println("방금 등록된 Work.no = " + no);
			
			// 3. attachment에 등록 
			PortAttachment attachment = work.getAttachment();
			if(attachment != null) {
				attachment.setNo(no);
				result = mypageDao.insertAttachment(conn, attachment);
			}
			
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		return result;
		
	}
	
	public int findCurrentWorkNo() {
		int result = 0;
		Connection conn = getConnection();
		
		try {	
			int no = mypageDao.findCurrentWorkNo(conn); // seq_board_no.currval
			System.out.println("방금 등록된 Work.no = " + no);
			
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	

}
