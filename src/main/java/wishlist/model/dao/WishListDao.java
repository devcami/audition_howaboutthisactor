package wishlist.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class WishListDao {
	private Properties prop = new Properties();
	
	public WishListDao() {
		String filename = WishListDao.class.getResource("/sql/wishlist-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
