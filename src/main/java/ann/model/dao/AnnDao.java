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
import common.model.dto.Cast;
import common.model.dto.Work;
import common.model.dto.WorkAttachment;

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

	private Ann handleAnnResultSet(ResultSet rset) throws SQLException {
		Ann ann = new Ann();
		ann.setAnnNo(rset.getInt("ann_no"));
		ann.setMemberId(rset.getString("member_id"));
		ann.setWorkNo(rset.getInt("work_no"));
		ann.setAnnTitle(rset.getString("ann_title"));
		ann.setAnnArea(rset.getString("ann_area"));
		ann.setAnnEndDate(rset.getDate("ann_end_date"));
		ann.setAnnRegDate(rset.getDate("ann_reg_date"));
		ann.setAnnPay(rset.getString("ann_pay"));
		ann.setAnnGender(rset.getString("ann_gender"));
		ann.setAnnAge(rset.getString("ann_age"));
		ann.setAnnHeight(rset.getString("ann_height"));
		ann.setAnnBody(rset.getString("ann_body"));
		ann.setAnnNop(rset.getInt("ann_nop"));
		ann.setIsClose(rset.getString("is_close"));
		ann.setHasTO(rset.getString("has_TO"));
		
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

	public List<Ann> annEndDateSort(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("annEndDateSort");
		
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
			throw new AnnException("> 공고찾기 - 공고 마감순정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public Ann findByAnnNo(Connection conn, int annNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Ann ann = null;
		String sql = prop.getProperty("findByAnnNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, annNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				ann = handleAnnResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세보기 한건 (공고)조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}

		
		return ann;
	}

	public Work findWorkByWorkNo(Connection conn, int workNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Work work = null;
		String sql = prop.getProperty("findWorkByWorkNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				work = handleWorkResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세보기 한건 (작품)조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return work;
	}

	private Work handleWorkResultSet(ResultSet rset) throws SQLException {
		Work work = new Work();
		work.setWorkNo(rset.getInt("work_no"));
		work.setWorkField(rset.getString("work_field"));
		work.setTitle(rset.getString("title"));
		work.setProduction(rset.getString("production"));
		work.setDirector(rset.getString("director"));
		work.setDescription(rset.getString("description"));
		
		return work;
	}

	public List<WorkAttachment> findAttachmentByWorkNo(Connection conn, int workNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<WorkAttachment> list = new ArrayList<>();
		String sql = prop.getProperty("findAttachmentByWorkNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				WorkAttachment workAttachment = handleAttachmentResultSet(rset);
				list.add(workAttachment);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세보기 한건 (첨부파일)조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	private WorkAttachment handleAttachmentResultSet(ResultSet rset) throws SQLException {
		WorkAttachment workAttachment = new WorkAttachment();
		workAttachment.setWorkNo(rset.getInt("work_no"));
		workAttachment.setWorkAttachmentNo(rset.getInt("work_attachment_no"));
		workAttachment.setOriginalFilename(rset.getString("original_filename"));
		workAttachment.setRenamedFilename(rset.getString("renamed_filename"));
		workAttachment.setRegDate(rset.getDate("reg_date"));
		
		return workAttachment;
	}

	public Cast findCastByWorkNo(Connection conn, int workNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Cast cast = null;
		String sql = prop.getProperty("findCastByWorkNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				cast = handleCastResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세보기 한건 (배역)조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return cast;
	}

	private Cast handleCastResultSet(ResultSet rset) throws SQLException {
		Cast cast = new Cast();
		cast.setWorkNo(rset.getInt("work_no"));
		cast.setCastNo(rset.getInt("cast_no"));
		cast.setCastRole(rset.getString("cast_role"));
		cast.setCastName(rset.getString("cast_name"));
		cast.setCastContents(rset.getString("cast_contents"));
		
		return cast;
	}
}
