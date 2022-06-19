package actor.model.dao;

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

import actor.model.exception.ActorException;
import ann.model.dto.Ann;
import mypage.model.dto.ActorInfo;
import mypage.model.dto.ActorInfoExt;
import mypage.model.dto.PortAttachment;


public class ActorDao {
private Properties prop = new Properties();
   
   public ActorDao() {
      String fileName = ActorDao.class.getResource("/sql/actor-query.properties").getPath();
      try {
         prop.load(new FileReader(fileName));
      } catch (IOException e) {
         e.printStackTrace();
      }
   }
      

	public List<ActorInfo> findActorInfo (Connection conn, Map<String, Object> param){
    	PreparedStatement pstmt = null;
    	ResultSet rset = null;
    	String sql = prop.getProperty("findActorInfo");
    	List<ActorInfo> list = new ArrayList<>();
		try {
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setInt(1, (int) param.get("start"));
  			pstmt.setInt(2, (int) param.get("end"));
  			rset = pstmt.executeQuery();
  			
  			while(rset.next()) {
  				ActorInfo actor = handleActorResultSet(rset);
  				list.add(actor); 
  			}
  		} catch (SQLException e) {
  			throw new ActorException("배우 조회 오류!", e);
  		} finally {
  			close(rset);
  			close(pstmt);
  		}
  		return list;
      }


	private ActorInfo handleActorResultSet(ResultSet rset) throws SQLException {
		ActorInfo actorInfo = new ActorInfo();
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
		return actorInfo;
	}

	public int getTotalContents(Connection conn) {
		  PreparedStatement pstmt = null;
    	  ResultSet rset = null;
    	  int totalContents =0;
  		
  		String sql = prop.getProperty("getTotalContent");
  		
  		
		try {
  			pstmt = conn.prepareStatement(sql);
  			rset = pstmt.executeQuery();
  			
  			while(rset.next()) { 
  				totalContents = rset.getInt(1);
  				 
  			}
		} catch (SQLException e) {
  			throw new ActorException(" 전체 배우 수 조회 오류!", e);
  		} finally {
  			close(rset);
  			close(pstmt);
  		}
  		
  			return totalContents;
	
	}


	public PortAttachment getfindActorProfile(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
    	ResultSet rset = null;
    	String sql = prop.getProperty("getfindActorProfile");
    	PortAttachment pa = new PortAttachment();
		try {
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1,memberId);
  		
  			rset = pstmt.executeQuery();
  			
  			while(rset.next()) {
  				pa.setNo(rset.getInt("no"));
  				pa.setMemberId(memberId);
  				pa.setOriginalFilename(rset.getString("original_filename"));
  				pa.setRenamedFilename(rset.getString("renamed_filename"));
  			}
  		} catch (SQLException e) {
  			throw new ActorException("배우 프로필사진 조회 오류!", e);
  		} finally {
  			close(rset);
  			close(pstmt);
  		}
  		return pa;
	}
	
	public ActorInfo getActorByActorNo(Connection conn, int actorNo) {
		PreparedStatement pstmt = null;
    	ResultSet rset = null;
    	String sql = prop.getProperty("getActorByActorNo");
    	ActorInfo actor = null;
		try {
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setInt(1, actorNo);
  			rset = pstmt.executeQuery();
  			while(rset.next()) {
  				actor = handleActorResultSet(rset);
  			}
  		} catch (SQLException e) {
  			throw new ActorException("배우 1명 조회 오류!", e);
  		} finally {
  			close(rset);
  			close(pstmt);
  		}
  		return actor;
	}


	public List<ActorInfo> findActorByName(Connection conn, Map<String, Object> param) {
    	PreparedStatement pstmt = null;
    	ResultSet rset = null;
    	String sql = prop.getProperty("findActorByName");
    	List<ActorInfo> list = new ArrayList<>();
		try {
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, "%" + (String) param.get("searchKeyword") + "%");
  			pstmt.setInt(2, (int) param.get("start"));
  			pstmt.setInt(3, (int) param.get("end"));
  			rset = pstmt.executeQuery();
  			
  			while(rset.next()) {
  				ActorInfo actor = handleActorResultSet(rset);
  				list.add(actor); 
  			}
  		} catch (SQLException e) {
  			throw new ActorException("배우 이름으로 검색 오류!", e);
  		} finally {
  			close(rset);
  			close(pstmt);
  		}
  		return list;
	}
}
    
	

