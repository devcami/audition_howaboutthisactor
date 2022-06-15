package actor.model.dao;

import static common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import actor.model.dto.ActorExt;
import actor.model.exception.ActorException;
import mypage.model.dto.ActorInfo;


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
      
      @SuppressWarnings("null")
	public List<ActorExt> findAll(Connection conn, Map<String, Object> param){
    	  PreparedStatement pstmt = null;
    	  ResultSet rset = null;
  		ActorInfo actorInfo = new ActorInfo();
  		String sql = prop.getProperty("findAll");
  		
  		java.util.List<ActorExt> list = null;
		try {
  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, (String) param.get("start"));
  			pstmt.setString(1, (String) param.get("end"));
  			rset = pstmt.executeQuery();
  			
  			while(rset.next()) {
  				ActorExt actor = new ActorExt();
  				actor.setMemberId(rset.getString("member_id"));
  				actor.setActorName(rset.getString("actor_name"));
  				actor.setActorNo(rset.getInt("actor_no"));
  				actor.setBirth(rset.getString("actor_birth"));
  				actor.setAge(rset.getInt("actor_age"));
  				actor.setEducation(rset.getString("actor_education"));
  				actor.setHeight(rset.getDouble("actor_height"));
  				actor.setWeight(rset.getDouble("actor_weight"));
  				actor.setCompany(rset.getString("actor_company"));
  				actor.setPhone(rset.getString("actor_phone"));
  				actor.setEmail(rset.getString("actor_email"));
  				actor.setSpeciality(rset.getString("actor_speciality"));
  				actor.setSns(rset.getString("actor_sns"));
  				actor.setAttachNo(rset.getInt("actor_photo"));
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
      
      
      
      
      
      
      
      
      
      
      
   }
