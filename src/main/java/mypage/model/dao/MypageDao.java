package mypage.model.dao;
import static common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;
import mypage.model.exception.MypageException;


public class MypageDao {
	private Properties prop = new Properties();
	
	public MypageDao() {
		String filename = MypageDao.class.getResource("/sql/mypage-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int insertPortWork(Connection conn, PortfolioWork work) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertPortWork");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, work.getMemberId());
			pstmt.setString(2, work.getTitle());
			pstmt.setString(3, work.getPeriod());
			pstmt.setString(4, work.getMyrole());
			pstmt.setString(5, work.getVideolink());
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			throw new MypageException("포트폴리오 경력 삽입 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int findCurrentWorkNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int no = 0;
		String sql = prop.getProperty("findCurrentWorkNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				no = rset.getInt(1);
			}
			
		} catch(SQLException e) {
			throw new MypageException("포트폴리오 작품 번호 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		System.out.println("PortfolioWork@no = " + no);
		
		return no;
	}

	public int insertAttachment(Connection conn, PortAttachment attachment) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, attachment.getMemberId());
			pstmt.setInt(2, attachment.getNo());
			pstmt.setString(3, attachment.getOriginalFilename());
			pstmt.setString(4, attachment.getRenamedFilename());
			pstmt.setString(5, attachment.getAttachType());
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			throw new MypageException("포트폴리오 경력사진 등록오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	
	
}
