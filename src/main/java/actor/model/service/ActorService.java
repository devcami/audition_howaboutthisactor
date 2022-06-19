package actor.model.service;
import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import actor.model.dao.ActorDao;
import board.model.dto.BoardExt;
import member.model.dto.Production;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.ActorInfoExt;
import mypage.model.dto.PortAttachment;



public class ActorService {
	
	public static final int NUM_PER_PAGE =12;
	private ActorDao actorDao = new ActorDao();
	
	public List<ActorInfo> findActorInfo(Map<String, Object>param) {
		Connection conn = getConnection();
		List<ActorInfo> list = actorDao.findActorInfo(conn,param);
		for(ActorInfo actor : list ) {
			PortAttachment pa = actorDao.getfindActorProfile(conn, actor.getMemberId());
			actor.setAttachment(pa);
		}	
		close(conn);
		return list;
	}


	public int getTotalContents() {
		Connection conn = getConnection();
		int totalContents = actorDao.getTotalContents(conn);
		close(conn);
		return totalContents;
	}


	public ActorInfo getActorByActorNo(int actorNo) {
		Connection conn = getConnection();
		ActorInfo actor = actorDao.getActorByActorNo(conn, actorNo);
		close(conn);
		return actor;
	}


	public List<ActorInfo> findActorByName(Map<String, Object> param) {
		Connection conn = getConnection();
		List<ActorInfo> list = actorDao.findActorByName(conn, param);
		for(ActorInfo actor : list) {
			PortAttachment pa = actorDao.getfindActorProfile(conn, actor.getMemberId());
			actor.setAttachment(pa);
		}	
		close(conn);
		return list;
	}
	

}
