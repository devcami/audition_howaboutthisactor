package member.model.dao;

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

import common.HelloMvcUtils;
import common.JdbcTemplate;
// import common.HelloMvcUtils;
// import common.JdbcTemplate;
import member.model.dto.Member;
import member.model.dto.MemberRole;
import member.model.exception.MemberException;

public class MemberDao {
	
	private Properties prop = new Properties();
	private Connection conn;
	
	public MemberDao() {
		// buildpath의 sql/member-query.properties파일의 내용을 불러오기
		String fileName = MemberDao.class.getResource("/sql/member-query.properties").getPath();
		try {
			prop.load(new FileReader(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public Member findByMemberId(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findByMemberId");
		Member member = null;
		
		try {
			// 1. pstmt객체 & 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			// 2. 실행 및 rset처리
			rset = pstmt.executeQuery();
			while(rset.next()) {
				member = handleMemberResultSet(rset);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3. 자원반납(rset, pstmt)
			close(rset);
			close(pstmt);
		}
		return member;
	}
	
	/* 
	public Member findPw(Connection conn, String memberId, String memberName) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findPw");
		Member member = null;
	/	
		try {
			// 1. pstmt객체 & 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2,  memberName);
			
			// 2. 실행 및 rset처리
			rset = pstmt.executeQuery();
			while(rset.next()) {
				member = handleMemberResultSet(rset);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3. 자원반납(rset, pstmt)
			close(rset);
			close(pstmt);
		}
		return member;
	}
	*/
	
	public Member findByEmail(Connection conn, String email) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findByEmail");
		Member member = null;
		
		try {
			// 1. pstmt객체 & 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			
			// 2. 실행 및 rset처리
			rset = pstmt.executeQuery();
			while(rset.next()) {
				member = handleMemberResultSet(rset);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 3. 자원반납(rset, pstmt)
			close(rset);
			close(pstmt);
		}
		return member;
	}
	
	public String findId(Connection conn, String memberName, String phone) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findId");
		String Id = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			pstmt.setString(2, phone);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Id = rset.getString("member_id");
			}
			System.out.println("dao단 아이디"+ Id);	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return Id;
	}


	public Member findPw(Connection conn, String memberId, String phone) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("findPw");
		Member member = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, phone);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				member = handleMemberResultSet(rset);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return member;
	}

	public void pwFindUpdate() {
		// 1. 회원아이디 조회 및 신규 비번 설정
		Connection conn = JdbcTemplate.getConnection();
		String sql = prop.getProperty("findPw");
		List<Member> list = new ArrayList<>();
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		){
			while(rset.next()) {
				String memberId = rset.getString("member_id");
				
				Member member = new Member();
				member.setMemberId(memberId);
				member.setPassword(HelloMvcUtils.encrypt("1234", memberId));
				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(list); 
		
		
		// 2. 비밀번호 업데이트
		sql = prop.getProperty("pwUpdate"); // update member set password = ? where member_id = ?
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			for(Member member : list) {
				pstmt.setString(1, member.getPassword());
				pstmt.setString(2, member.getMemberId());
				pstmt.executeUpdate();
				System.out.println("변경완료 : " + member.getMemberId() + " / " + member.getPassword());
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	
	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		Member member = new Member();
		member.setMemberId(rset.getString("member_id"));
		member.setPassword(rset.getString("password"));
		member.setMemberName(rset.getString("member_name"));
		member.setMemberRole(MemberRole.valueOf(rset.getString("member_role")));
		member.setGender(rset.getString("gender"));
		member.setBirthday(rset.getDate("birthday"));
		member.setEmail(rset.getString("email"));
		member.setPhone(rset.getString("phone"));
		member.setGenre(rset.getString("genre"));
		member.setEnrollDate(rset.getDate("enroll_date"));
		return member;
	}

	public int insertMember(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getMemberRole().toString());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getGender());
			pstmt.setDate(8, member.getBirthday());
			pstmt.setString(9, member.getGenre());
			
			result = pstmt.executeUpdate();	
			
			
		} catch (SQLException e) {
			throw new MemberException("회원가입오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	/**
	 * 1건 조회시 member객체 하나 또는 null 리턴
	 * n건 조회시 여러건의 member객체를 가진 list 또는 빈 list
	 * 
	 * @param conn
	 * @param param 
	 * @return
	 */
	public List<Member> findAll(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) param.get("start"));
			pstmt.setInt(2, (int) param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Member member = handleMemberResultSet(rset);
				list.add(member);
			}
		} catch (Exception e) {
			throw new MemberException("관리자 회원목록 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}


	public List<Member> findBy(Connection conn, Map<String, String> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Member> list = new ArrayList<>();
		String sql = prop.getProperty("findBy");
		sql = sql.replace("#", param.get("searchType"));
		System.out.println("sql = " + sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + param.get("searchKeyword") + "%");
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Member member = handleMemberResultSet(rset);
				list.add(member);
			}
		} catch (Exception e) {
			throw new MemberException("관리자 회원검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public int getTotalContents(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContents = 0;
		String sql = prop.getProperty("getTotalContents");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next())
				totalContents = rset.getInt(1); // 컬럼인덱스
		} catch (Exception e) {
			throw new MemberException("전체회원수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContents;
	}

	public int idDuplicationCheck(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		String sql = prop.getProperty("idDuplicationCheck");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				result = rset.getInt(1);
			}
		} catch (Exception e) {
			throw new MemberException("아이디 중복 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int updatePw(Connection conn, String memberId, String newPw) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updatePw");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPw);
			pstmt.setString(2, memberId);
			result = pstmt.executeUpdate();	
		} catch (Exception e) {
			throw new MemberException("비밀번호 찾기-변경 오류", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
}
