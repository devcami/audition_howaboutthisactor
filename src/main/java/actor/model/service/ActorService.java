package actor.model.service;
import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import actor.model.dao.ActorDao;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.PortAttachment;



public class ActorService {
	
	public static final int NUM_PER_PAGE =12;
	private ActorDao actorDao = new ActorDao();
	
	public List<ActorInfo> findActorInfo(Map<String, Object>param) {
		Connection conn=getConnection();
		List<ActorInfo> list = actorDao.findActorInfo(conn,param);
		for(ActorInfo actor : list ) {
			PortAttachment pa = actorDao.getfindActorProfile(conn, actor.getMemberId());
			actor.setAttachment(pa);
			
			
		}	
		close(conn);
		return list;
	}


	public int getTotalContents() {
		Connection conn=getConnection();
		int totalContents = actorDao.getTotalContents(conn);
		close(conn);
		return totalContents;
	}

//		
//	public List<ActorInfo> detailActorInfo(Map<String, Object>param) {
//		Connection conn = getConnection();
//		List<ActorInfo> list = actorDao.detailActorInfo(conn,param);
//		
//	}
}
