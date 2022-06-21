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
	
	public Member findByEmail(String email) {
		Connection conn = getConnection();
		Member member = memberDao.findByEmail(conn, email);
		close(conn);
		return member;
	}
	
	public String findId(String memberName, String phone) {
		Connection conn = getConnection();
		String Id = memberDao.findId(conn, memberName, phone);
		System.out.println("service단 아이디"+ Id);
		close(conn);
		return Id;
	}
	/*
	public Member findPw(String memberId, String memberName) {
		Connection conn = getConnection();
		Member member = memberDao.findPw(conn, memberId, memberName);
		System.out.println("service단 아이디확인"+ memberId);
		System.out.println("service단 이름확인" + memberName);
		close(conn);
		return member;
	}
	*/
	
	public Member findPw(String memberId, String phone) {
		Connection conn = getConnection();
		Member member = memberDao.findPw(conn, memberId, phone);
		close(conn);
		return member;
	}
/*	
	public String pwUpdate(Member member) {
		int result = 0;
		Connection conn = getConnection();
		try {
//			result = memberDao.pwUpdate(conn, member);
//			System.out.println("service단 아이디확인"+ memberId);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
//		return result;

	}
	*/
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

	public int idDuplicationCheck(String memberId) {
		Connection conn = getConnection();
		int result = memberDao.idDuplicationCheck(conn, memberId);
		close(conn);
		return result;
	}

	public int updatePw(String memberId, String newPw) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.updatePw(conn, memberId, newPw);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; 
		} finally {
			close(conn);			
		}
		return result;
	}
}
