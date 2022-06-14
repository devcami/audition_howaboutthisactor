package member.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;
import static common.JdbcTemplate.commit;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import member.model.dao.MemberDao;
import member.model.dto.Member;

public class MemberService {
	
	public static final int NUM_PER_PAGE = 10;
	private MemberDao memberDao = new MemberDao();
	
	public Member findByMemberId(String memberId) {
		Connection conn = getConnection();
		Member member = memberDao.findByMemberId(conn, memberId);
		close(conn);
		return member;
	}
	
	public int insertMember(Member member) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.insertMember(conn, member);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; // controller에게 통보용!
		} finally {
			close(conn);			
		}
		return result;
	}

	
	public List<Member> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> list = memberDao.findAll(conn, param);
		close(conn);
		return list;
	}

	public int updateMemberRole(Member member) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.updateMemberRole(conn, member);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Member> findBy(Map<String, String> param) {
		Connection conn = getConnection();
		List<Member> list = memberDao.findBy(conn, param);
		close(conn);
		return list;
	}
	
	public int getTotalContents() {
		Connection conn = getConnection();
		int totalContents = memberDao.getTotalContents(conn);
		close(conn);
		return totalContents;
	}
}
