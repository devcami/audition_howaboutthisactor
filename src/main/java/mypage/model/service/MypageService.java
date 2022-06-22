package mypage.model.service;
import static common.JdbcTemplate.close;
import static common.JdbcTemplate.commit;
import static common.JdbcTemplate.getConnection;
import static common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import ann.model.dto.Ann;
import board.model.dto.Board;
import board.model.dto.Report;
import common.model.dto.WorkAttachment;
import member.model.dto.Member;
import member.model.dto.Production;
import mypage.model.dao.MypageDao;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.ActorInfoExt;
import mypage.model.dto.PortAttachment;
import mypage.model.dto.PortAttachmentExt;
import mypage.model.dto.PortfolioWork;
import mypage.model.dto.PortfolioWorkExt;

public class MypageService {
	
	private MypageDao mypageDao = new MypageDao();
	public static final int APPLY_NUM_PER_PAGE = 8;
	public static final int ANN_NUM_PER_PAGE = 8;
	public static final int BOARD_NUM_PER_PAGE = 15;
	public static final int REPORT_NUM_PER_PAGE = 15;
	public static final int MEMBER_NUM_PER_PAGE = 15;

	
	public List<Integer> insertPortWork(PortfolioWorkExt work) {
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
			PortAttachment attach1 = work.getAttach1();
			PortAttachment attach2 = work.getAttach2();
			PortAttachment attach3 = work.getAttach3();
			
			if(attachment != null) {
				attachment.setNo(no);
				result = mypageDao.insertAttachment(conn, attachment, "W");
			}
			if(attach1 != null) {
				attach1.setNo(no);
				result = mypageDao.insertAttachment(conn, attach1, "WW");
			}
			if(attach2 != null) {
				attach2.setNo(no);
				result = mypageDao.insertAttachment(conn, attach2, "WW");
			}
			if(attach3 != null) {
				attach3.setNo(no);
				result = mypageDao.insertAttachment(conn, attach3, "WW");
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
	            result = mypageDao.deleteWorkAttachment(conn, Integer.parseInt(no));
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
	
	public int getTotalUndoReport() {
		Connection conn = getConnection();
		int totalContent = mypageDao.getTotalUndoReport(conn);
		close(conn);
		return totalContent;
	}
	
	public int getTotalIngReport() {
		Connection conn = getConnection();
		int totalContent = mypageDao.getTotalIngReport(conn);
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

	public int updateMember(Member member) {
		int result = 0;
		// 1. Connection 객체 생성
		Connection conn = getConnection();
		try {
			// 2. dao 요청
			result = mypageDao.updateMember(conn, member); 
					
			// 3. 트랜잭션 처리 - commit
			commit(conn);
		} catch(Exception e) {
			// 3. 트랜잭션 처리 - rollback 
			rollback(conn);
			throw e;  // controller 통보용
		} finally {
			// 4. Connection 객체 반환
			close(conn); 
		}
		return result;
	}

	/**
	 * 은민 부분
	 */
	public List<PortAttachment> findAllAttachmentByMemberId(String memberId) {
		Connection conn = getConnection();
		List<PortAttachment> list = mypageDao.findAllAttachmentByMemberId(conn, memberId);
		close(conn);
		return list;
	}

	public Production getProductionInfo(String memberId) {
		Connection conn = getConnection();
		Production production = mypageDao.getProductionInfo(conn, memberId);
		close(conn);
		return production;
	}

	public int updateProduction(Production production) {
		int result = 0;
		// 1. Connection 객체 생성
		Connection conn = getConnection();
		try {
			// 2. dao 요청
			result = mypageDao.updateProduction(conn, production); 
					
			// 3. 트랜잭션 처리 - commit
			commit(conn);
		} catch(Exception e) {
			// 3. 트랜잭션 처리 - rollback 
			rollback(conn);
			throw e;  // controller 통보용
		} finally {
			// 4. Connection 객체 반환
			close(conn); 
		}
		return result;
	}

	public List<Member> findAllMember(Map<String, Object> param) {
		
		Connection conn = getConnection();
		List<Member> list = mypageDao.findAllMember(conn, param);
		close(conn);
		return list;
		
	}

	public int getTotalMember() {
		Connection conn = getConnection();
		int totalContents = mypageDao.getTotalMember(conn);
		close(conn);
		return totalContents;
	}

	public List<Member> findBy(Map<String, String> param, Map<String, Object> pageParam) {
		Connection conn = getConnection();
		List<Member> list = mypageDao.findBy(conn, param, pageParam);
		close(conn);
		return list;
	}

	public int getTotalSearchedMember(Map<String, String> param) {
		Connection conn = getConnection();
		int totalContents = mypageDao.getTotalSearchedMember(conn, param);
		close(conn);
		return totalContents;
	}

	public List<Integer> GetMyApplys(String memberId) {
		Connection conn = getConnection();
		List<Integer> myApplys = mypageDao.GetMyApplys(conn, memberId);
		close(conn);
		return myApplys;
	}

	public List<Ann> findAllMyApply(Map<String, Object> param, String myApplys) {
		Connection conn = getConnection();
		List<Ann> list = mypageDao.findAllMyApply(conn, param, myApplys);
		close(conn);
		return list;
	}

	public List<Ann> myApplyEndDateSort(Map<String, Object> param, String myApplys) {
		Connection conn = getConnection();
		List<Ann> list = mypageDao.myApplyEndDateSort(conn, param, myApplys);
		close(conn);
		return list;
	}

	public List<Ann> findMyAllCurrentAnn(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = mypageDao.findMyAllCurrentAnn(conn, memberId, param);
		close(conn);
		return list;
	}
	
	public int getTotalMyCurrentAnn(String memberId) {
		
		Connection conn = getConnection();
		int totalContent = mypageDao.getTotalMyCurrentAnn(conn, memberId);
		close(conn);
		return totalContent;
	}

//	public List<String> findApplicantActorNo(String annNo) {
//
//		Connection conn = getConnection();
//		List<String> list = mypageDao.findApplicantActorId(conn, annNo);
//		close(conn);
//		return list;
//		
//	}

	public List<ActorInfo> findApplicantActor(String annNo) {
		Connection conn = getConnection();
		List<ActorInfo> actorList = new ArrayList<>();
		List<String> actorIdList = mypageDao.findApplicantActorId(conn, annNo);
		try {	
			for(int i = 0; i < actorIdList.size(); i++) {
				ActorInfo actor = new ActorInfo();
				actor = mypageDao.findActorInfo(conn, actorIdList.get(i));
				PortAttachment profilePic = mypageDao.getProfilePic(conn, actorIdList.get(i), "P");
				actor.setAttachment(profilePic);
				
				actorList.add(actor);			
			}
			
		} catch(Exception e) {
			throw e;	
		} finally {
			close(conn);
		}
		
		return actorList;
	}

	public int isProduction(String memberId) {
		Connection conn = getConnection();
		int isProduction = mypageDao.isProduction(conn, memberId);
		close(conn);
		return isProduction;
	}

	public int insertProduction(Production production) {

		int result = 0;
		// 1. Connection 객체 생성
		Connection conn = getConnection();
		try {
			// 2. dao 요청
			result = mypageDao.insertProduction(conn, production); 
					
			// 3. 트랜잭션 처리 - commit
			commit(conn);
		} catch(Exception e) {
			// 3. 트랜잭션 처리 - rollback 
			rollback(conn);
			throw e;  // controller 통보용
		} finally {
			// 4. Connection 객체 반환
			close(conn); 
		}
		return result;
	}

	public List<Board> findMyBoardByTitle(String searchKeyword, String memberId) {
		Connection conn = getConnection();
		List<Board> list = mypageDao.findMyBoardByTitle(conn, searchKeyword, memberId);
		close(conn);
		return list;
	}

	public List<PortAttachment> getAllWorkAttach(String memberId, int workNo) {
		Connection conn = getConnection();
		List<PortAttachment> list = mypageDao.getSubWorkAttach(conn, memberId, workNo);
		
		PortAttachment bossAttach = mypageDao.getBossWorkAttach(conn, memberId, workNo);
		list.add(0, bossAttach);
		
		close(conn);
		return list;
		
	}

	public PortAttachment findOneAttachByPaNo(int paNo) {
		Connection conn = getConnection();
		PortAttachment attach = mypageDao.findOneAttachByPaNo(conn, paNo);
		close(conn);
		return attach;
	}

	public int deleteWorkAttachmentByNo(int paNo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = mypageDao.deleteWorkAttachmentByNo(conn, paNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int updatePortWork(PortfolioWorkExt work) {
		int result = 0;
		Connection conn = getConnection();
		
		System.out.println(work);
		
		try {
			// 1. portfolio_work 업데이트
			result = mypageDao.updatePortWork(conn, work);

			// 3. attachment 업데이트
			PortAttachment attachment = work.getAttachment();
			PortAttachment attach1 = work.getAttach1();
			PortAttachment attach2 = work.getAttach2();
			PortAttachment attach3 = work.getAttach3();

			System.out.println("attachment = " + attachment);
			System.out.println("attach1 = " + attach1);
			System.out.println("attach2 = " + attach2);
			System.out.println("attach3 = " + attach3);
			
			if(attachment != null) {
				result = mypageDao.insertAttachment(conn, attachment, "W");
			}
			if(attach1 != null) {
				result = mypageDao.insertAttachment(conn, attach1, "WW");
			}
			if(attach2 != null) {
				result = mypageDao.insertAttachment(conn, attach2, "WW");
			}
			if(attach3 != null) {
				result = mypageDao.insertAttachment(conn, attach3, "WW");
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

	public PortfolioWorkExt findWorkByNo(int workNo, String memberId) {
		Connection conn = getConnection();
		PortfolioWorkExt work = new PortfolioWorkExt();
		try {
			work = mypageDao.getWorkByNo(conn, workNo);
			PortAttachment bossAttach = mypageDao.getBossWorkAttach(conn, memberId, workNo);
			work.setAttachment(bossAttach);
			
			List<PortAttachment> list = mypageDao.getSubWorkAttach(conn, memberId, workNo);
			
			if(list.size() == 1) {
				work.setAttach1(list.get(0));
			}
			if(list.size() == 2) {
				work.setAttach1(list.get(0));
				work.setAttach2(list.get(1));
			}
			if(list.size() == 3) {
				work.setAttach1(list.get(0));
				work.setAttach2(list.get(1));
				work.setAttach3(list.get(2));
			}
			
			
			close(conn);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return work;
	}

	public PortAttachment getBossWorkAttach(String memberId, int workNo) {
		Connection conn = getConnection();
		PortAttachment bossAttach = mypageDao.getBossWorkAttach(conn, memberId, workNo);
		close(conn);
		return bossAttach;
	}

	public String getVideo(int workNo) {
		Connection conn = getConnection();
		String v = mypageDao.getVideo(conn, workNo);
		close(conn);
		return v;
	}


	
}
