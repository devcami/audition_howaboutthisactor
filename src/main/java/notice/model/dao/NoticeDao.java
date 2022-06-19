package notice.model.dao;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

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


import board.model.dto.Attachment;
import notice.model.dto.Notice;
import notice.model.dto.NoticeExt;
import notice.model.exception.NoticeException;

public class NoticeDao {

	private Properties prop = new Properties();
	
	public NoticeDao() {
		String fileName = NoticeDao.class.getResource("/sql/notice-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<NoticeExt> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<NoticeExt> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				NoticeExt notice = handleNoticeResultSet(rset);
				list.add(notice);
			}
			
		} catch (Exception e) {
			throw new NoticeException("회원목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	private NoticeExt handleNoticeResultSet(ResultSet rset) throws SQLException {
		NoticeExt notice = new NoticeExt();
		notice.setNo(rset.getInt("no"));
		notice.setTitle(rset.getString("title"));
		notice.setMemberId(rset.getString("member_id"));
		notice.setContent(rset.getString("content"));
		notice.setReadCount(rset.getInt("read_count"));				
		notice.setRegDate(rset.getDate("reg_date"));				
		return notice;
	}

	public int getTotalContents(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getTotalContents");
		int totalContents = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				totalContents = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new NoticeException("총게시물수 조회 오류");
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContents;
	}

	public int insertNotice(Connection conn, Notice notice) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertNotice");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getMemberId());
			pstmt.setString(3, notice.getContent());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new NoticeException("게시글 등록 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int findCurrentNoticeNo(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int no = 0;
		String sql = prop.getProperty("findCurrentBoardNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next())
				no = rset.getInt(1);
			
		} catch (SQLException e) {
			throw new NoticeException("게시글번호 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return no;
	}
	
	public NoticeExt findByNo(Connection conn, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		NoticeExt notice = null;
		String sql = prop.getProperty("findByNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				notice = handleNoticeResultSet(rset);
			}
		} catch (SQLException e) {
			throw new NoticeException("게시글 한건 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return notice;
	}

	public int updateReadCount(Connection conn, int no) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateReadCount");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new NoticeException("조회수 증가처리 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
    public int deleteNotice(Connection conn, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteBoard"); 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new NoticeException("게시글 삭제 오류", e);
		} finally {
			close(pstmt);
		}

		
		return result;
	}

	public int updateNotice(Connection conn, NoticeExt notice) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateBoard");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getContent());
			pstmt.setInt(3, notice.getNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			throw new NoticeException("게시글 수정 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

}















