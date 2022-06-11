package mypage.model.service;
import static common.JdbcTemplate.*;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import mypage.model.dao.MypageDao;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;

public class MypageService {
	
	private MypageDao mypageDao = new MypageDao();

	public List<Integer> insertPortWork(PortfolioWork work) {
		List<Integer> resultNo = new ArrayList<>();
		int result = 0;
		Connection conn = getConnection();
		
		try {
			// 1. portfolio_work에 등록
			result = mypageDao.insertPortWork(conn, work); // pk no값 결정 - seq_board_no
			
			// 2. portfolio_work pk 가져오기
			int no = mypageDao.findCurrentWorkNo(conn); // seq_board_no.currval
			System.out.println("방금 등록된 Work.no = " + no);
			
			resultNo.add(result);
			resultNo.add(no);
			
			// 3. attachment에 등록 
			PortAttachment attachment = work.getAttachment();
			if(attachment != null) {
				attachment.setNo(no);
				result = mypageDao.insertAttachment(conn, attachment);
			}
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		return resultNo;
		
	}
	
	public int findCurrentWorkNo() {
		Connection conn = getConnection();
		int no = 0;
		
		try {	
			no = mypageDao.findCurrentWorkNo(conn); // seq_board_no.currval
			System.out.println("방금 등록된 Work.no = " + no);
			
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		return no;
	}

	public int deleteWorks(String[] deleteArr) {
		int result = 0;
		Connection conn = getConnection();
		
		try {

			
			for(String no : deleteArr) {   
	            result = mypageDao.deleteWorks(conn, Integer.parseInt(no));
	            System.out.println(no + "번 지우기 성공!");
			}
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
