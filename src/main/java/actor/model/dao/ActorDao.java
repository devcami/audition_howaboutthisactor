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
import mypage.model.dto.ActorInfo;
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
		ActorInfo actor = new ActorInfo();
		actor.setMemberId(rset.getString("member_id"));
		actor.setActorName(rset.getString("actor_name"));
		actor.setActorNo(rset.getInt("actor_no"));
		actor.setBirth(rset.getString("actor_birth"));
		actor.setAge(rset.getInt("actor_age"));
		actor.setCompany(rset.getString("actor_company"));
		actor.setHeight(rset.getDouble("actor_height"));
		actor.setWeight(rset.getDouble("actor_weight"));
		actor.setAttachNo(rset.getInt("actor_photo"));
		return actor;
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
  			throw new ActorException("배우 조회 오류!", e);
  		} finally {
  			close(rset);
  			close(pstmt);
  		}
  		
  		return pa;
      }
	}
      
	
   
