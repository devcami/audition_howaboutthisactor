package ann.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import static common.JdbcTemplate.*;

import ann.model.dto.Ann;
import ann.model.exception.AnnException;

public class AnnDao {
	private Properties prop = new Properties();
	
	public AnnDao() {
		String filename = AnnDao.class.getResource("/sql/ann-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getTotalContent(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalContent");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 전체 게시물 수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}
//
//	public List<Ann> regDatePage(Connection conn, Map<String, Integer> param) {
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		String sql = prop.getProperty("regDatePage");
//		List<Ann> list = new ArrayList<>();
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, param.get("start"));
//			pstmt.setInt(2, param.get("end"));
//			rset = pstmt.executeQuery();
//			while(rset.next()) {
//				Ann ann = handleAnnResultSet(rset);
//				list.add(ann);
//			}
//		} catch (Exception e) {
//			throw new AnnException("> 더보기 페이지 조회 오류");
//		} finally {
//			close(rset);
//			close(pstmt);
//		}
//		return list;
//	}
//	
//	public List<Ann> endDatePage(Connection conn, Map<String, Integer> param) {
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		String sql = prop.getProperty("endDatePage");
//		List<Ann> list = new ArrayList<>();
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, param.get("start"));
//			pstmt.setInt(2, param.get("end"));
//			rset = pstmt.executeQuery();
//			while(rset.next()) {
//				Ann ann = handleAnnResultSet(rset);
//				list.add(ann);
//			}
//		} catch (Exception e) {
//			throw new AnnException("> 더보기 페이지 조회 오류");
//		} finally {
//			close(rset);
//			close(pstmt);
//		}
//		return list;
//	}
//	
//	public List<Ann> findByTitle(Connection conn, Map<String, String> param) {
//		PreparedStatement pstmt = null;
//		ResultSet rset = null;
//		List<Ann> list = new ArrayList<>();
//		String sql = prop.getProperty("findByTitle");
//		try {
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, param.get("searchKeyword"));
//			rset = pstmt.executeQuery();
//			while(rset.next()) {
//				Ann ann = handleAnnResultSet(rset);
//				list.add(ann);
//			}
//		} catch (Exception e) {
//			throw new AnnException("> 공고 검색 오류");
//		} finally {
//			close(rset);
//			close(pstmt);
//		}
//		return list;
//	}

	private Ann handleAnnResultSet(ResultSet rset) throws SQLException {
		Ann ann = new Ann();
		ann.setAnnNo(rset.getInt("ann_no"));
		ann.setMemberId(rset.getString("member_id"));
		ann.setWorkNo(rset.getInt("work_no"));
		ann.setAnnArea(rset.getString("ann_area"));
		ann.setAnnEndDate(rset.getDate("ann_end_date"));
		ann.setAnnRegDate(rset.getDate("ann_reg_date"));
		ann.setAnnPay(rset.getInt("ann_pay"));
		ann.setAnnGender(rset.getString("ann_gender"));
		ann.setAnnAge(rset.getInt("ann_age"));
		ann.setAnnHeight(rset.getDouble("ann_height"));
		ann.setAnnBody(rset.getString("ann_body"));
		ann.setAnnTitle(rset.getString("ann_title"));
		
		return ann;
	}

	public List<Ann> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				list.add(ann);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고찾기 - 공고 전체목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
}
