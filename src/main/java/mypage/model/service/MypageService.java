package mypage.model.service;
import static common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ann.model.dto.Ann;
import board.model.dto.Board;
import board.model.dto.Report;
import mypage.model.dao.MypageDao;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortfolioWork;

public class MypageService {
	
	private MypageDao mypageDao = new MypageDao();
	public static final int APPLY_NUM_PER_PAGE = 8;
	public static final int ANN_NUM_PER_PAGE = 8;
	public static final int BOARD_NUM_PER_PAGE = 15;
	public static final int REPORT_NUM_PER_PAGE = 15;

	
	public List<Integer> insertPortWork(PortfolioWork work) {
		List<Integer> resultNo = new ArrayList<>();
		int result = 0;
		Connection conn = getConnection();
		
		try {
			// 1. portfolio_work에 등록
			result = mypageDao.insertPortWork(conn, work); // pk no값 결정 - seq_board_no
			
			// 2. portfolio_work pk 가져오기
			int no = mypageDao.findCurrentWorkNo(conn); // seq_board_no.currval
			System.out.println("방금 등록된 Work.no = " + no);
			
			resultNo.add(result);
			resultNo.add(no);
			
			// 3. attachment에 등록 
			PortAttachment attachment = work.getAttachment();
			if(attachment != null) {
				attachment.setNo(no);
				result = mypageDao.insertAttachment(conn, attachment);
			}
			
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		return resultNo;
		
	}
	
	public int findCurrentWorkNo() {
		Connection conn = getConnection();
		int no = mypageDao.findCurrentWorkNo(conn); // seq_board_no.currval
		System.out.println("방금 등록된 Work.no = " + no);
		close(conn);
		return no;
	}

	public int deleteWorks(String[] deleteArr) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			for(String no : deleteArr) {   
	            result = mypageDao.deleteWorks(conn, Integer.parseInt(no));
	            System.out.println(no + "번 경력 지우기 성공!");
			}
			commit(conn);
			
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		
		return result;
	}

	public ActorInfo findActorInfo(String memberId) {
		Connection conn = getConnection();	
		ActorInfo actorInfo = mypageDao.findActorInfo(conn, memberId);
		close(conn);
		return actorInfo;
	}

	public String getRenamedFilename(int attachNo) {
		Connection conn = getConnection();
		String fileName = mypageDao.getRenamedFilename(conn, attachNo);
		close(conn);
		return fileName;
	}

	public List<PortfolioWork> findAllWork(String memberId) {
		Connection conn = getConnection();
		List<PortfolioWork> works = new ArrayList<>();
		try {
			works = mypageDao.findAllWork(conn, memberId);
			
			// works에서 번호 하나씩 꺼내서 port_attachment에서 그 번호에   맞는 renamedFilename 찾아서 삽입
			for(int i = 0; i < works.size(); i++) {
				int workNo = works.get(i).getNo();
				PortAttachment attach = mypageDao.findWorkAttachment(conn, workNo);	
				works.get(i).setAttachment(attach);
			}
			
		} catch(Exception e) {
			throw e;	
		} finally {
			close(conn);
		}
		
		return works;
	}

	public List<Integer> insertPortAttachment(PortAttachment attachment, int oldAttachNo) {
		List<Integer> resultNo = new ArrayList<>();
		int result = 0;
		Connection conn = getConnection();
		
		try {
			// 1. PortAttachment에 attachment insert
			result = mypageDao.insertPortAttachment(conn, attachment); // pk no값 결정 - seq_port_attachment_no
						
			// 2. portAttachment pk 가져오기
			int attachNo = mypageDao.findCurrentPortAttachmentNo(conn); // seq_port_attachment_no.currval
			System.out.println("MypageService@방금 등록된 PortAttachment.no = " + attachNo);
			
			// 3. 예전 프로필사진 삭제
			result = mypageDao.deleteOldProfilePic(conn, oldAttachNo);
			
			resultNo.add(result);
			resultNo.add(attachNo);
			
			commit(conn);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			close(conn);
		}		
		return resultNo;
	}

	
	public int updatePortfolio(ActorInfo actorInfo) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = mypageDao.updatePortfolio(conn, actorInfo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
			throw e;
		} finally {
			close(conn);
		}
	
		return result;
	}

	public int enrollPortfolio(ActorInfo actorInfo) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			result = mypageDao.enrollPortfolio(conn, actorInfo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	}

	public int getTotalMyAnn(String memberId) {
		
		Connection conn = getConnection();
		int totalContent = mypageDao.getTotalMyAnn(conn, memberId);
		close(conn);
		return totalContent;
	}

	public List<Ann> myAnnEndDateSort(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = mypageDao.myAnnEndDateSort(conn, memberId, param);
		close(conn);
		return list;
	}


	public List<Ann> findMyAllAnn(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = mypageDao.findMyAllAnn(conn, memberId, param);
		close(conn);
		return list;
	}

	public int deleteAnns(String[] deleteArr) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			for(String no : deleteArr) {   
	            result = mypageDao.deleteAnns(conn, Integer.parseInt(no));
	            System.out.println(no + "번 공고 지우기 성공!");
			}
			commit(conn);
			
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		
		return result;
		
	}

	public int getTotalMyBoard(String memberId) {
		Connection conn = getConnection();
		int totalContent = mypageDao.getTotalMyBoard(conn, memberId);
		close(conn);
		return totalContent;
	}

	public List<Board> myBoardEndDateSort(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Board> list = mypageDao.myBoardEndDateSort(conn, memberId, param);
		close(conn);
		return list;
		
	}

	public List<Board> findMyAllBoard(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Board> list = mypageDao.findMyAllBoard(conn, memberId, param);
		close(conn);
		return list;
	}

	public int deleteBoards(String[] deleteBoard) {
		int result = 0;
		Connection conn = getConnection();
		
		try {
			for(String no : deleteBoard) {   
	            result = mypageDao.deleteBoards(conn, Integer.parseInt(no));
	            System.out.println(no + "번 게시글 지우기 성공!");
			}
			commit(conn);
			
		} catch(Exception e) {
			rollback(conn);
		 	throw e;
		} finally {
			close(conn);
		}
		
		return result;
	}

	public String getPw(String memberId) {
		
		Connection conn = getConnection();
		String password = mypageDao.getPw(conn, memberId);
		close(conn);
		
		return password;
	}

	public int deleteMember(String memberId) {
		int result = 0;
		// 1. Connection객체 생성
		Connection conn = getConnection();
		try {
			// 2. dao 요청
			result = mypageDao.deleteMember(conn, memberId);
			// 3. 트랜잭션 처리
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e; // controller 통보용
		} finally {
			// 4. Connection객체 반환
			close(conn);
		}
		return result;
	}

	public int getTotalReport() {
		Connection conn = getConnection();
		int totalContent = mypageDao.getTotalReport(conn);
		close(conn);
		return totalContent;
	}

	public List<Report> ReportUndoList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Report> list = mypageDao.ReportUndoList(conn, param);
		close(conn);
		return list;
	}

	public List<Report> ReportIngList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Report> list = mypageDao.ReportIngList(conn, param);
		close(conn);
		return list;
	}

	public List<Report> ReportEndList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Report> list = mypageDao.ReportEndList(conn, param);
		close(conn);
		return list;
	}

	public List<Report> ReportList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Report> list = mypageDao.ReportList(conn, param);
		close(conn);
		return list;
		
	}
	

}
