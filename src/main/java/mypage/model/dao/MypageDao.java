package mypage.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;


public class MypageDao {
	private Properties prop = new Properties();
	
	public MypageDao() {
		String filename = MypageDao.class.getResource("/sql/mypage-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
}
