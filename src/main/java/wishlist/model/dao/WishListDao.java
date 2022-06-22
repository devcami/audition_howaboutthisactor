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
import mypage.model.dto.ActorInfo;
import mypage.model.dto.PortAttachment;
import wishlist.model.dto.WishListActor;
import wishlist.model.dto.WishListAnn;
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
			throw new WishListException("> getTotalContent@배우 마이페이지 찜목록 전체 게시물 수 조회 오류");
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
			throw new WishListException("> 공고찾기 - 공고 마감순정렬 오류", e);
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
			throw new WishListException("> 공고찾기 - 공고 전체목록 조회 오류", e);
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
//		ann.setIsClose(rset.getString("is_close"));
		
		return ann;
	}

	public int getTotalActorWishContent(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalActorWishContent");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new WishListException("> getTotalActorWishContent@제작사 마이페이지 찜목록 전체 게시물 수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}

	public List<ActorInfo> actorEndDateSort(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ActorInfo> list = new ArrayList<>();
		String sql = prop.getProperty("actorEndDateSort");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				ActorInfo actor = handleActorResultSet(rset);
				list.add(actor);
			}
		} catch (Exception e) {
			throw new WishListException("> 공고찾기 - 공고 마감순정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public List<ActorInfo> findAllWishActor(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ActorInfo> list = new ArrayList<>();
		String sql = prop.getProperty("findAllWishActor");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				ActorInfo actor = handleActorResultSet(rset);
				list.add(actor);
			}
		} catch (Exception e) {
			throw new WishListException("> 공고찾기 - 공고 전체목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	private ActorInfo handleActorResultSet(ResultSet rset) throws SQLException {
		
		ActorInfo actor = new ActorInfo();
		
		actor.setActorName(rset.getString("actor_name"));
		actor.setMemberId(rset.getString("member_id"));
		actor.setActorNo(rset.getInt("actor_no"));
		actor.setBirth(rset.getString("actor_birth"));
		actor.setAge(rset.getInt("actor_age"));
		actor.setCompany(rset.getString("actor_company"));
		
		return actor;
	}

	public PortAttachment getProfilePic(Connection conn, String actor, String type) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		PortAttachment attachment = new PortAttachment();
		String sql = prop.getProperty("getProfilePic");
		attachment.setAttachType(type);
		attachment.setMemberId(actor);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, actor);
			pstmt.setString(2, type);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				
				attachment.setNo(rset.getInt("no"));
				attachment.setOriginalFilename(rset.getString("original_filename"));
				attachment.setRenamedFilename(rset.getString("renamed_filename"));
				attachment.setRegDate(rset.getDate("reg_date"));
				
			}
		} catch (Exception e) {
			throw new WishListException("> getProfilePic@내가 찜한 배우 프로필사진 조회오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return attachment;
	}

	public List<WishListAnn> annWishlistbyMemberId(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<WishListAnn> list = new ArrayList<>();
		String sql = prop.getProperty("annWishlistbyMemberId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				WishListAnn wishlistAnn = new WishListAnn();
				wishlistAnn.setMemberId(rset.getString("member_id"));
				wishlistAnn.setAnnNo(rset.getInt("ann_no"));
				list.add(wishlistAnn);
			}
			
		} catch (Exception e) {
			throw new WishListException("> 위시리스트 로그인아이디로 조회오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int addWishlistAnn(Connection conn, WishListAnn wishListAnn) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("addWishlistAnn");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, wishListAnn.getMemberId());
			pstmt.setInt(2, wishListAnn.getAnnNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 위시리스트 - 공고 찜목록 추가 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int delWishlistAnn(Connection conn, WishListAnn wishListAnn) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delWishlistAnn");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wishListAnn.getAnnNo());
			pstmt.setString(2, wishListAnn.getMemberId());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 위시리스트 - 공고 찜목록 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public List<WishListActor> actorWishlistbyMemberId(Connection conn, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<WishListActor> list = new ArrayList<>();
		String sql = prop.getProperty("actorWishlistbyMemberId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				WishListActor wishlistActor = new WishListActor();
				wishlistActor.setMemberId(rset.getString("member_id"));
				wishlistActor.setActorNo(rset.getInt("actor_no"));
				list.add(wishlistActor);
			}
			
		} catch (Exception e) {
			throw new WishListException("> 위시리스트 로그인아이디로 조회오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int addWishlistActor(Connection conn, WishListActor wishListActor) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("addWishlistActor");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, wishListActor.getMemberId());
			pstmt.setInt(2, wishListActor.getActorNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 위시리스트 - 배우 찜목록 추가 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int delWishlistActor(Connection conn, WishListActor wishListActor) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delWishlistActor");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wishListActor.getActorNo());
			pstmt.setString(2, wishListActor.getMemberId());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 위시리스트 - 배우 찜목록 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
}
