package ann.model.service;

import static common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import ann.model.dao.AnnDao;
import ann.model.dto.Ann;

public class AnnService {
	public static final int NUM_PER_PAGE = 12;
	private AnnDao annDao = new AnnDao();
	
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = annDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public List<Ann> findMorePage(Map<String, Integer> param) {
		Connection conn = getConnection();
		List<Ann> list = annDao.findMorePage(conn, param);
		close(conn);
		return list;
	}
}
