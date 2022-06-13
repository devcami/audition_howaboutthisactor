package wishlist.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import ann.model.dto.Ann;
import wishlist.model.dao.WishListDao;

public class WishListService {
	private WishListDao wishListDao = new WishListDao();
	public static final int WISH_NUM_PER_PAGE = 8;

	/**
	 * 은성부분
	 * @author jes
	 */
	public int getTotalContent(String memberId) {
		Connection conn = getConnection();
		int totalContent = wishListDao.getTotalContent(conn, memberId);
		close(conn);
		return totalContent;
		
	}

	public List<Ann> annEndDateSort(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = wishListDao.annEndDateSort(conn, memberId, param);
		close(conn);
		return list;
	}

	public List<Ann> findAll(String memberId, Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = wishListDao.findAll(conn, memberId, param);
		close(conn);
		return list;
	}
	
	
}
