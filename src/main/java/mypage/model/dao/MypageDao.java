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
import board.model.dto.Board;
import board.model.dto.Report;
import common.model.dto.WorkAttachment;
import member.model.dto.Member;
import member.model.dto.MemberRole;
import member.model.dto.Production;
import member.model.exception.MemberException;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.ActorInfoExt;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;
import mypage.model.dto.PortfolioWorkExt;
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

	public int insertAttachment(Connection conn, PortAttachment attachment, String attachType) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, attachment.getMemberId());
			pstmt.setInt(2, attachment.getNo());
			pstmt.setString(3, attachment.getOriginalFilename());
			pstmt.setString(4, attachment.getRenamedFilename());
			pstmt.setString(5, attachType);
			
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
	
	public int deleteWorkAttachment(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteWorkAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MypageException("deleteWorkAttachment@포트폴리오 경력 첨부파일 삭제오류!", e);
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
			// 왜 안돼 ㅅㅂ
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
			pstmt.setString(13, actorInfo.getEmail());;
			
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
//		ann.setIsClose(rset.getString("is_close"));
		
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
			throw new MypageException("MypageDao@ 내 공고 삭제오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int getTotalMyBoard(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalMyBoard");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new MypageException("> getTotalMyBoard@마이페이지 내 전체 게시글수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}
	private Board handleBoardResultSet(ResultSet rset) throws SQLException {
		Board board = new Board();
		
		board.setNo(rset.getInt("no"));
		board.setMemberId(rset.getString("member_Id"));
		board.setTitle(rset.getString("title"));
		board.setContent(rset.getString("content"));
		board.setReadCount(rset.getInt("read_count"));
		board.setRegDate(rset.getDate("reg_date"));
		
		return board;
	}

	public List<Board> myBoardEndDateSort(Connection conn, String memberId, Map<String, Object> param) {
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Board> list = new ArrayList<>();
		String sql = prop.getProperty("myBoardEndDateSort");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Board board = handleBoardResultSet(rset);
				list.add(board);
			}
		} catch (Exception e) {
			throw new MypageException("> 게시물찾기 - 게시물 오래된 순 정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public List<Board> findMyAllBoard(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Board> list = new ArrayList<>();
		String sql = prop.getProperty("findMyAllBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, (int) param.get("start"));
			pstmt.setInt(3, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Board board = handleBoardResultSet(rset);
				list.add(board);
			}
		} catch (Exception e) {
			throw new MypageException("> 게시물찾기 - 게시물 전체조회(최신순) 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public int deleteBoards(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBoards");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MypageException("MypageDao@ 내 게시글 삭제 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}


	public String getPw(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getPw");
		String password = "";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				password = rset.getString(1);
			}
		} catch (Exception e) {
			throw new MypageException("> getPw@마이페이지 비밀번호 확인 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return password;
	}

	public int deleteMember(Connection conn, String memberId) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteMember"); 

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memberId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MypageException("deleteMember@회원탈퇴 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int getTotalReport(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalReport");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new MypageException("> getTotalReport@신고리스트 전체 게시글수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}
	
	public int getTotalUndoReport(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalUndoReport");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new MypageException("> getTotalUndoReport@신고리스트(undo) 전체 게시글수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}
	
	public int getTotalIngReport(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalIngReport");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new MypageException("> getTotalUndoReport@신고리스트(Ing) 전체 게시글수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}

	private Report handleReportResultSet(ResultSet rset) throws SQLException {
		Report report = new Report();
		
		report.setNo(rset.getInt("no"));
		report.setMemberId(rset.getString("member_Id"));
		report.setAnnNo(rset.getInt("ann_no"));
		report.setActor_no(rset.getInt("actor_no"));
		report.setBoardNo(rset.getInt("board_no"));
		report.setCommentNo(rset.getInt("comment_no"));
		report.setReportContent(rset.getString("report_content"));
		report.setReportDate(rset.getDate("report_date"));
		report.setReportStatus(rset.getString("report_status"));
		
		return report;
	}
	
	
	public List<Report> ReportUndoList(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Report> list = new ArrayList<>();
		String sql = prop.getProperty("ReportUndoList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Report report = handleReportResultSet(rset);
				list.add(report);
			}
		} catch (Exception e) {
			throw new MypageException("> 신고내역조회 - undo 신고 정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public List<Report> ReportIngList(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Report> list = new ArrayList<>();
		String sql = prop.getProperty("ReportIngList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Report report = handleReportResultSet(rset);
				list.add(report);
			}
		} catch (Exception e) {
			throw new MypageException("> 신고내역조회 - Ing 신고 정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Report> ReportEndList(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Report> list = new ArrayList<>();
		String sql = prop.getProperty("ReportEndList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Report report = handleReportResultSet(rset);
				list.add(report);
			}
		} catch (Exception e) {
			throw new MypageException("> 신고내역조회 - End 신고 정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public List<Report> ReportList(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Report> list = new ArrayList<>();
		String sql = prop.getProperty("ReportList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Report report = handleReportResultSet(rset);
				list.add(report);
			}
		} catch (Exception e) {
			throw new MypageException("> 신고내역조회 - 전체 신고 정렬 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public int updateMember(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateMember");
		
		try {
			// 1. pstmt 객체 생성 & 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getGender());
			pstmt.setDate(6, member.getBirthday());
			pstmt.setString(7, member.getGenre());
			pstmt.setString(8, member.getMemberId());

			// 2. 실행
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MemberException("회원정보수정 오류", e);
		} finally {
			// 3. 자원반납 - pstmt
			close(pstmt);
		}
		
		return result;
	}


	public List<PortAttachment> findAllAttachmentByMemberId(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<PortAttachment> list = new ArrayList<>();
		String sql = prop.getProperty("findAllAttachmentByMemberId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				PortAttachment pa = new PortAttachment();
				pa.setNo(rset.getInt("no"));
				pa.setMemberId(memberId);
				pa.setOriginalFilename(rset.getString("original_filename"));
				pa.setRenamedFilename(rset.getString("renamed_filename"));
				pa.setAttachType(rset.getString("attach_type"));
				pa.setRegDate(rset.getDate("reg_date"));
				list.add(pa);
			}
		} catch (Exception e) {
			throw new MypageException("> 게시물찾기 - 게시물 전체조회(최신순) 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public Production getProductionInfo(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Production production = new Production();
		String sql = prop.getProperty("getProductionInfo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				// production.setMemberId(rset.getString("member_id"));
				production.setProductionName(rset.getString("production_name"));
				production.setCasterName(rset.getString("caster_name"));
				production.setCasterPhone(rset.getString("caster_phone"));
				production.setCasterEmail(rset.getString("caster_email"));
				production.setIsPhoneOpen(rset.getString("is_phone_open"));
				production.setIsEmailOpen(rset.getString("is_email_open"));
				
			}
		} catch (Exception e) {
			throw new MypageException("> 회사정보 불러오기 옲 ", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return production;
	}

	public int updateProduction(Connection conn, Production production) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateProduction");
		
		try {
			// 1. pstmt 객체 생성 & 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, production.getProductionName());
			pstmt.setString(2, production.getCasterName());
			pstmt.setString(3, production.getCasterPhone());
			pstmt.setString(4, production.getCasterEmail());
			pstmt.setString(5, production.getIsPhoneOpen());
			pstmt.setString(6, production.getIsEmailOpen());
			pstmt.setString(7, production.getMemberId());

			// 2. 실행
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MemberException("회사정보수정 오류", e);
		} finally {
			// 3. 자원반납 - pstmt
			close(pstmt);
		}
		
		return result;
	}

	public List<Member> findAllMember(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = new ArrayList<>();
		String sql = prop.getProperty("findAllMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Member member = handleMemberResultSet(rset);
				list.add(member);
			}
			
		} catch(Exception e) {
			throw new MemberException("관리자 회원 목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
		
	}

	public int getTotalMember(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContents = 0;
		String sql = prop.getProperty("getTotalMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				totalContents = rset.getInt(1);  // 컬럼 인덱스로 가져오기
			}			
		} catch (Exception e) {
			throw new MemberException("전체회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}
	
	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		
		Member member = new Member();
		
		member.setMemberId(rset.getString("member_id"));
		member.setPassword(rset.getString("password"));
		member.setMemberName(rset.getString("member_name"));
		member.setEmail(rset.getString("email"));
		// 문자열 "U" -> MemberRole.U, "A" -> MemberRole.A
		member.setMemberRole(MemberRole.valueOf(rset.getString("member_role")));
		member.setPhone(rset.getString("phone"));
		member.setGender(rset.getString("gender"));
		member.setBirthday(rset.getDate("birthday"));
		member.setEnrollDate(rset.getDate("enroll_date"));
		member.setGenre(rset.getString("genre"));
		
		return member;
	}

	public List<Member> findBy(Connection conn, Map<String, String> param, Map<String, Object> pageParam) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = new ArrayList<>();
		String sql = prop.getProperty("findBy");
		sql = sql.replace("#", param.get("searchType"));
		System.out.println("sql = " + sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + param.get("searchKeyword") + "%");
			pstmt.setInt(2, (int) pageParam.get("start"));
			pstmt.setInt(3, (int) pageParam.get("end"));
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Member member = handleMemberResultSet(rset);
				list.add(member);
			}
			
		} catch(Exception e) {
			throw new MemberException("관리자 회원 검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int getTotalSearchedMember(Connection conn, Map<String, String> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContents = 0;
		String sql = prop.getProperty("getTotalSearchedMember");
		sql = sql.replace("#", param.get("searchType"));
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + param.get("searchKeyword") + "%");
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				totalContents = rset.getInt(1);  // 컬럼 인덱스로 가져오기
			}			
		} catch (Exception e) {
			throw new MemberException("관리자 회원 검색 전체 회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}

	public List<Integer> GetMyApplys(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Integer> myApplys = new ArrayList<>();
		String sql = prop.getProperty("GetMyApplys");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				int no = rset.getInt("ann_no");
				myApplys.add(no);
			}
			
		} catch(Exception e) {
			throw new MemberException("GetMyApplys@내 ann_no 찾기 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return myApplys;
		
	}

	public List<Ann> findAllMyApply(Connection conn, Map<String, Object> param, String myApplys) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> myApplyAnns = new ArrayList<>();
		String sql = prop.getProperty("findAllMyApply");
		sql = sql.replace("#", myApplys);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Ann ann = new Ann();
				
				ann.setAnnNo(rset.getInt("ann_no"));
				ann.setMemberId(rset.getString("member_Id"));
				ann.setAnnTitle(rset.getString("ann_title"));
				ann.setAnnRegDate(rset.getDate("ann_reg_date"));
				ann.setAnnEndDate(rset.getDate("ann_end_date"));
//				ann.setIsClose(rset.getString("is_close"));
				
				myApplyAnns.add(ann);
			}			
		} catch (Exception e) {
			throw new MemberException("내 지원목록 최신순 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return myApplyAnns;
	}

	public List<Ann> myApplyEndDateSort(Connection conn, Map<String, Object> param, String myApplys) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> myApplyAnns = new ArrayList<>();
		String sql = prop.getProperty("myApplyEndDateSort");
		sql = sql.replace("#", myApplys);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Ann ann = new Ann();
				
				ann.setAnnNo(rset.getInt("ann_no"));
				ann.setMemberId(rset.getString("member_Id"));
				ann.setAnnTitle(rset.getString("ann_title"));
				ann.setAnnRegDate(rset.getDate("ann_reg_date"));
				ann.setAnnEndDate(rset.getDate("ann_end_date"));
//				ann.setIsClose(rset.getString("is_close"));
				
				myApplyAnns.add(ann);
			}			
		} catch (Exception e) {
			throw new MemberException("내 지원목록 마감순 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return myApplyAnns;
		
	}
	
	
	public int getTotalMyCurrentAnn(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalMyCurrentAnn");
		int totalContent = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new WishListException("> getTotalMyAnn@마이페이지 내 전체공고(진행중인) 수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return totalContent;
	}

	public List<Ann> findMyAllCurrentAnn(Connection conn, String memberId, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Ann> list = new ArrayList<>();
		String sql = prop.getProperty("findMyAllCurrentAnn");
		
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
			throw new AnnException("> 공고찾기 - 공고 전체목록(진행중인) 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}

	public List<String> findApplicantActorId(Connection conn, String annNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<String> actors = new ArrayList<>();
		String sql = prop.getProperty("findApplicantActorId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(annNo));
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				String actorId = rset.getString("member_id");
				actors.add(actorId);
			}
			
		} catch(Exception e) {
			throw new MemberException("findApplicantActorId@내공고 지원자 아이디 찾기 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return actors;
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
			throw new WishListException("> getProfilePic@내 공고 지원 배우 프로필사진 조회오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return attachment;
	}

	public int isProduction(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("isProduction");
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new MypageException("> isProduction@회사정보 있는지 없는지 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}		
		return result;
		
		
	}

	public int insertProduction(Connection conn, Production production) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertProduction");
		
		try {
			// 1. pstmt 객체 생성 & 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, production.getMemberId());
			pstmt.setString(2, production.getProductionName());
			pstmt.setString(3, production.getCasterName());
			pstmt.setString(4, production.getCasterPhone());
			pstmt.setString(5, production.getCasterEmail());
			pstmt.setString(6, production.getIsPhoneOpen());
			pstmt.setString(7, production.getIsEmailOpen());

			// 2. 실행
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new MemberException("insertProduction@회사정보입력 오류", e);
		} finally {
			// 3. 자원반납 - pstmt
			close(pstmt);
		}
		
		return result;
	}

	public List<Board> findMyBoardByTitle(Connection conn, String searchKeyword, String memberId) {

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Board> list = new ArrayList<>();
		String sql = prop.getProperty("findMyBoardByTitle");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, "%" + searchKeyword + "%");
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Board board = handleBoardResultSet(rset);
				list.add(board);
			}
		} catch (Exception e) {
			throw new AnnException("> 내게시물 찾기 - 게시물 제목으로 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}


	public List<PortAttachment> getSubWorkAttach(Connection conn, String memberId, int workNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<PortAttachment> list = new ArrayList<>();
		String sql = prop.getProperty("getSubWorkAttach");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, workNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				PortAttachment attach = handleAttachResultSet(rset);
				list.add(attach);
			}
		} catch (Exception e) {
			throw new AnnException("> workAttach(WW) 찾기 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public PortAttachment getBossWorkAttach(Connection conn, String memberId, int workNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		PortAttachment attach = new PortAttachment();
		String sql = prop.getProperty("getBossWorkAttach");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, workNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attach = handleAttachResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> workAttach(W-경력대표사진) 찾기 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return attach;
	}
	
	private PortAttachment handleAttachResultSet(ResultSet rset) throws SQLException {
		PortAttachment attach = new PortAttachment();
		attach.setAttachType(rset.getString("attach_type"));
		attach.setMemberId(rset.getString("memberId"));
		attach.setNo(rset.getInt("no"));
		attach.setOriginalFilename(rset.getString("original_Filename"));
		attach.setRenamedFilename(rset.getString("renamed_Filename"));
		attach.setRegDate(rset.getDate("reg_date"));		
		return attach;
	}

	public PortAttachment findOneAttachByPaNo(Connection conn, int paNo) {
		PortAttachment attach = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findOneAttachByPaNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attach = handleAttachResultSet(rset);
			}
		} catch (Exception e) {
			throw new AnnException("> 경력수정 - 작품 첨부파일 한건 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return attach;
	}

	public int deleteWorkAttachmentByNo(Connection conn, int paNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteWorkAttachmentByNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paNo);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new AnnException("> 경력수정 - 작품 첨부파일 삭제 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updatePortWork(Connection conn, PortfolioWorkExt work) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updatePortWork");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, work.getTitle());
			pstmt.setString(2, work.getPeriod());
			pstmt.setString(3, work.getMyrole());
			pstmt.setString(4, work.getVideolink());
			pstmt.setInt(5, work.getNo());
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			throw new MypageException("updatePortWork@포트폴리오 경력 수정 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
		
	}

	public PortfolioWorkExt getWorkByNo(Connection conn, int workNo) {
		PortfolioWorkExt work = new PortfolioWorkExt();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getWorkByNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				work.setNo(workNo);
				work.setMemberId(rset.getString("member_Id"));
				work.setTitle(rset.getString("title"));
				work.setPeriod(rset.getString("period"));
				work.setMyrole(rset.getString("myrole"));
				work.setVideolink(rset.getString("youtube"));
			}
		} catch (Exception e) {
			throw new AnnException("> 경력상세조회 - getWorkByNo 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return work;
	}

	public String getVideo(Connection conn, int workNo) {
		String video = "";
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getVideo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				video = rset.getString("youtube");
			}
		} catch (Exception e) {
			throw new AnnException("> 경력상세조회 - getWorkByNo 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return video;
	}
	
	
}
