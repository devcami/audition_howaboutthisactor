package mypage.model.dao;
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
import mypage.model.dto.PortfolioWork;
import mypage.model.exception.MypageException;
import wishlist.model.exception.WishListException;


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

	public int deleteWorks(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteWorks");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MypageException("포트폴리오 경력 삭제오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public ActorInfo findActorInfo(Connection conn, String memberId) {
		ActorInfo actorInfo = new ActorInfo();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("findActorInfo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				actorInfo.setMemberId(rset.getString("member_id"));
				actorInfo.setActorName(rset.getString("actor_name"));
				actorInfo.setActorNo(rset.getInt("actor_no"));
				actorInfo.setBirth(rset.getString("actor_birth"));
				actorInfo.setAge(rset.getInt("actor_age"));
				actorInfo.setEducation(rset.getString("actor_education"));
				actorInfo.setHeight(rset.getDouble("actor_height"));
				actorInfo.setWeight(rset.getDouble("actor_weight"));
				actorInfo.setCompany(rset.getString("actor_company"));
				actorInfo.setPhone(rset.getString("actor_phone"));
				actorInfo.setEmail(rset.getString("actor_email"));
				actorInfo.setSpeciality(rset.getString("actor_speciality"));
				actorInfo.setSns(rset.getString("actor_sns"));
				actorInfo.setAttachNo(rset.getInt("actor_photo"));
			}
			
		} catch (SQLException e) {
			throw new MypageException("포트폴리오 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return actorInfo;
	}

	public String getRenamedFilename(Connection conn, int attachNo) {
		String fileName = "";
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("getRenamedFilename");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attachNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				fileName = rset.getString(1);
			}
		
		} catch (SQLException e) {
			throw new MypageException("프로필사진 RenamedFilename 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return fileName;
	}

	public List<PortfolioWork> findAllWork(Connection conn, String memberId) {
		List<PortfolioWork> works = new ArrayList<>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("findAllWork");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				PortfolioWork work = new PortfolioWork();
				
				work.setNo(rset.getInt("no"));
				work.setMemberId(rset.getString("member_id"));
				work.setTitle(rset.getString("title"));
				work.setPeriod(rset.getString("period"));
				work.setMyrole(rset.getString("myrole"));
				work.setVideolink(rset.getString("youtube"));
				
				works.add(work);	
			}
		
		} catch (SQLException e) {
			throw new MypageException("포트폴리오 경력 조회오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return works;

	}

	public PortAttachment findWorkAttachment(Connection conn, int workNo) {
		PortAttachment attach = new PortAttachment();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("findWorkAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				attach.setAttachType(rset.getString("attach_type"));
				attach.setMemberId(rset.getString("memberId"));
				attach.setNo(rset.getInt("no"));
				attach.setOriginalFilename(rset.getString("original_filename"));
				attach.setRenamedFilename(rset.getString("renamed_filename"));
				attach.setRegDate(rset.getDate("reg_date"));				
			}
			
		} catch (SQLException e) {
			throw new MypageException("포트폴리오 경력 파일 조회오류!", e);
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return attach;
	}

	public int insertPortAttachment(Connection conn, PortAttachment attachment) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertPortAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, attachment.getMemberId());
			pstmt.setString(2, attachment.getOriginalFilename());
			pstmt.setString(3, attachment.getRenamedFilename());
			pstmt.setString(4, attachment.getAttachType());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MypageException("insertPortAttachment@프로필사진 등록오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int findCurrentPortAttachmentNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int no = 0;
		String sql = prop.getProperty("findCurrentPortAttachmentNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				no = rset.getInt(1);
			}
			
		} catch(SQLException e) {
			throw new MypageException("findCurrentPortAttachmentNo@프로필사진파일 번호 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		System.out.println("PortfolioWork@no = " + no);
		
		return no;
	}

	public int updatePortfolio(Connection conn, ActorInfo actorInfo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updatePortfolio");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, actorInfo.getAge());
			pstmt.setString(2, actorInfo.getEducation());
			pstmt.setDouble(3, actorInfo.getHeight());
			pstmt.setDouble(4, actorInfo.getWeight());
			pstmt.setString(5, actorInfo.getCompany());
			pstmt.setString(6, actorInfo.getSpeciality());
			pstmt.setString(7, actorInfo.getSns());
			pstmt.setString(8, Integer.toString(actorInfo.getAttachNo()));
			pstmt.setString(9, actorInfo.getActorName());
			pstmt.setString(10, actorInfo.getBirth());
			pstmt.setString(11, actorInfo.getPhone());
			pstmt.setString(12, actorInfo.getEmail());
			pstmt.setString(13, actorInfo.getMemberId());
			
			result = pstmt.executeUpdate();
			
		} catch(SQLException e) {
			throw new MypageException("updatePortfolio@프로필 업데이트 오류!", e);
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int enrollPortfolio(Connection conn, ActorInfo actorInfo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("enrollPortfolio");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, actorInfo.getMemberId());
			
			pstmt.setInt(2, actorInfo.getAge());
			pstmt.setString(3, actorInfo.getEducation());
			pstmt.setDouble(4, actorInfo.getHeight());
			pstmt.setDouble(5, actorInfo.getWeight());
			pstmt.setString(6, actorInfo.getCompany());
			pstmt.setString(7, actorInfo.getSpeciality());
			pstmt.setString(8, actorInfo.getSns());
			pstmt.setString(9, Integer.toString(actorInfo.getAttachNo()));
			pstmt.setString(10, actorInfo.getActorName());
			pstmt.setString(11, actorInfo.getBirth());
			pstmt.setString(12, actorInfo.getPhone());
			pstmt.setString(13, actorInfo.getEmail());
			
			result = pstmt.executeUpdate();
			
		} catch(SQLException e) {
			throw new MypageException("enrollPortfolio@프로필 삽입 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteOldProfilePic(Connection conn, int oldAttachNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteOldProfilePic");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, oldAttachNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MypageException("insertPortAttachment@예전 프로필사진 삭제오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int getTotalMyAnn(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalMyAnn");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new WishListException("> getTotalMyAnn@마이페이지 내 전체공고 수 조회 오류");
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
	
	
	public List<Ann> myAnnEndDateSort(Connection conn, String memberId, Map<String, Object> param) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("myAnnEndDateSort");
		
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

	public List<Ann> findMyAllAnn(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("findMyAllAnn");
		
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

	public int deleteAnns(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteAnns");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MypageException("포트폴리오 경력 삭제오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	
	
	
}
