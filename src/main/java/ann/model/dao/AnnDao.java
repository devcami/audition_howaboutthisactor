package ann.model.dao;

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
import common.model.dto.Cast;
import common.model.dto.Work;
import common.model.dto.WorkAttachment;
import member.model.dto.Production;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.ActorInfoExt;

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
		ann.setHasTO(rset.getString("has_TO"));
		
		return ann;
	}

	public List<Ann> findAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
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

	public List<Ann> annEndDateSort(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("annEndDateSort");
		
		try {
			pstmt = conn.prepareStatement(sql);
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
	
	public List<Ann> annPopSort(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("annPopSort");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				list.add(ann);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고찾기 - 공고 인기순정렬 오류", e);
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

	public int insertWork(Connection conn, Work work) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertWork");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, work.getWorkField());
			pstmt.setString(2, work.getTitle());
			pstmt.setString(3, work.getProduction());
			pstmt.setString(4, work.getDirector());
			pstmt.setString(5, work.getDescription());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 작품 등록 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int findCurrentWorkNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int workNo = 0;
		String sql = prop.getProperty("findCurrentWorkNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				workNo = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 방금 등록 작품번호 가져오기 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return workNo;
	}

	public int insertWorkAttachment(Connection conn, WorkAttachment attach) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertWorkAttachment");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attach.getWorkNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 작품 첨부파일 등록 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateProduction(Connection conn, Production p) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateProduction");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p.getIsPhoneOpen());
			pstmt.setString(2, p.getIsEmailOpen());
			pstmt.setString(3, p.getMemberId());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 이메일, 휴대폰 비공개 수정 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertCast(Connection conn, Cast cast) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertCast");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cast.getWorkNo());
			pstmt.setString(2, cast.getCastRole());
			pstmt.setString(3, cast.getCastName());
			pstmt.setString(4, cast.getCastContents());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 배역 등록 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertAnn(Connection conn, Ann ann) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAnn");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ann.getMemberId());
			pstmt.setInt(2, ann.getWorkNo());
			pstmt.setString(3, ann.getAnnTitle());
			pstmt.setString(4, ann.getAnnArea());
			pstmt.setDate(5, ann.getAnnEndDate());
			pstmt.setString(6, ann.getAnnPay());
			pstmt.setString(7, ann.getAnnGender());
			pstmt.setString(8, ann.getAnnAge());
			pstmt.setString(9, ann.getAnnHeight());
			pstmt.setString(10, ann.getAnnBody());
			pstmt.setInt(11, ann.getAnnNop());
			pstmt.setString(12, ann.getHasTO());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 최종 공고 등록 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public Production findProductionByMemberId(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Production p = null;
		String sql = prop.getProperty("findProductionByMemberId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				p = handleProductionResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세보기 한건 (배역)조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return p;
	}

	private Production handleProductionResultSet(ResultSet rset) throws SQLException {
		Production p = new Production();
		p.setMemberId(rset.getString("member_id"));
		p.setProductionName(rset.getString("production_name"));
		p.setCasterName(rset.getString("caster_name"));
		p.setCasterPhone(rset.getString("caster_phone"));
		p.setCasterEmail(rset.getString("caster_email"));
		p.setIsPhoneOpen(rset.getString("is_phone_open"));
		p.setIsEmailOpen(rset.getString("is_email_open"));
		return p;
	}

	public int deleteAnn(Connection conn, int annNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteAnn");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, annNo);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public WorkAttachment findOneAttachByWaNo(Connection conn, int waNo) {
		WorkAttachment attach = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findOneAttachByWaNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, waNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attach = handleAttachmentResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고수정 - 작품 첨부파일 한건 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return attach;
	}

	public int deleteWorkAttachment(Connection conn, int waNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteWorkAttachment");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, waNo);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고수정 - 작품 첨부파일 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateWork(Connection conn, Work work) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateWork");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, work.getWorkField());
			pstmt.setString(2, work.getTitle());
			pstmt.setString(3, work.getProduction());
			pstmt.setString(4, work.getDirector());
			pstmt.setString(5, work.getDescription());
			pstmt.setInt(6, work.getWorkNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 작품 수정 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateCast(Connection conn, Cast cast) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateCast");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cast.getCastRole());
			pstmt.setString(2, cast.getCastName());
			pstmt.setString(3, cast.getCastContents());
			pstmt.setInt(4, cast.getCastNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 배역 수정 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateAnn(Connection conn, Ann ann) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateAnn");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ann.getAnnTitle());
			pstmt.setString(2, ann.getAnnArea());
			pstmt.setDate(3, ann.getAnnEndDate());
			pstmt.setString(4, ann.getAnnPay());
			pstmt.setString(5, ann.getAnnGender());
			pstmt.setString(6, ann.getAnnAge());
			pstmt.setString(7, ann.getAnnHeight());
			pstmt.setString(8, ann.getAnnBody());
			pstmt.setInt(9, ann.getAnnNop());
			pstmt.setString(10, ann.getHasTO());
			pstmt.setInt(11, ann.getAnnNo());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고 등록 - 최종 공고 수정 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public List<Ann> findByAnnTitle(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("findByAnnTitle");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchKeyword + "%");
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				list.add(ann);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고찾기 - 공고 제목으로 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int insertAnnReport(Connection conn, Map<String, Object> param) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAnnReport");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String) param.get("memberId"));
			pstmt.setInt(2, (int) param.get("annNo"));
			pstmt.setString(3, (String) param.get("reportContent"));
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고찾기 - 공고 신고하기 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int insertAnnApply(Connection conn, Map<String, Object> param) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAnnApply");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String) param.get("memberId"));
			pstmt.setInt(2, (int) param.get("annNo"));
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 공고찾기 - 공고 지원하기 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public List<ActorInfoExt> getApplyList(Connection conn, ActorInfo actorInfo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ActorInfoExt> annApplyList = new ArrayList<>();
		String sql = prop.getProperty("getApplyList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, actorInfo.getMemberId());
			rset = pstmt.executeQuery();
			while(rset.next()) {
				ActorInfoExt a = new ActorInfoExt(actorInfo, 0);
				a.setApplyAnnNo(rset.getInt("ann_no"));
				annApplyList.add(a);
			}
		} catch (Exception e) {
			throw new AnnException("> 공고지원 - 로그인멤버의 지원내역 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return annApplyList;
	}

	public int getTotalByTitle(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalByTitle");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchKeyword + "%");
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

	public List<Ann> detailFinderGender(Connection conn, String annGender, List<Ann> list) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("detailFinderGender");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, annGender);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				for(int i = 0; i < list.size(); i++) {
					if(list.get(i).getAnnNo() == ann.getAnnNo())
						list.remove(i);
				}
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세 게시물 검색 - 성별 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public List<Ann> detailFinderAge(Connection conn, String annAge, List<Ann> list) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("detailFinderAge");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, annAge);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				for(int i = 0; i < list.size(); i++) {
					if(list.get(i).getAnnNo() == ann.getAnnNo())
						list.remove(i);
				}
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세 게시물 검색 - 나이 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public List<Ann> detailFinderHeight(Connection conn, String annHeight, List<Ann> list) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("detailFinderHeight");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, annHeight);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				for(int i = 0; i < list.size(); i++) {
					if(list.get(i).getAnnNo() == ann.getAnnNo())
						list.remove(i);
				}
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세 게시물 검색 - 키 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public List<Ann> detailFinderBody(Connection conn, String annBody, List<Ann> list) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("detailFinderBody");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, annBody);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann ann = handleAnnResultSet(rset);
				for(int i = 0; i < list.size(); i++) {
					if(list.get(i).getAnnNo() == ann.getAnnNo())
						list.remove(i);
				}
			}
		} catch (Exception e) {
			throw new AnnException("> 공고 상세 게시물 검색 - 체형 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Ann> findMorePage(Connection conn, Map<String, Integer> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findMorePage");
		List<Ann> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, param.get("start"));
			pstmt.setInt(2, param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Ann photo = handleAnnResultSet(rset);
				list.add(photo);
			}
		} catch (Exception e) {
			throw new AnnException("> 더보기 페이지 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

}
