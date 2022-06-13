package wishlist.model.dao;

import static common.JdbcTemplate.close;

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

import ann.model.dto.Ann;
import ann.model.exception.AnnException;
import wishlist.model.exception.WishListException;

public class WishListDao {
	private Properties prop = new Properties();
	
	public WishListDao() {
		String filename = WishListDao.class.getResource("/sql/wishlist-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getTotalContent(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalContent");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new WishListException("> getTotalContent@마이페이지 찜목록 전체 게시물 수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}

	public List<Ann> annEndDateSort(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("annEndDateSort");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				list.add(ann);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고찾기 - 공고 마감순정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Ann> findAll(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
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
	
	private Ann handleAnnResultSet(ResultSet rset) throws SQLException {
		Ann ann = new Ann();
		ann.setAnnNo(rset.getInt("ann_no"));
		ann.setMemberId(rset.getString("member_id"));
//		ann.setWorkNo(rset.getInt("work_no"));
		ann.setAnnTitle(rset.getString("ann_title"));
//		ann.setAnnArea(rset.getString("ann_area"));
		ann.setAnnEndDate(rset.getDate("ann_end_date"));
		ann.setAnnRegDate(rset.getDate("ann_reg_date"));
//		ann.setAnnPay(rset.getString("ann_pay"));
//		ann.setAnnGender(rset.getString("ann_gender"));
//		ann.setAnnAge(rset.getString("ann_age"));
//		ann.setAnnHeight(rset.getString("ann_height"));
//		ann.setAnnBody(rset.getString("ann_body"));
//		ann.setAnnNop(rset.getInt("ann_nop"));
		ann.setIsClose(rset.getString("is_close"));
		
		return ann;
	}
}
