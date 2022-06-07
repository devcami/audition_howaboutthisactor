package ann.model.service;

import static common.JdbcTemplate.close;
import static common.JdbcTemplate.getConnection;

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

//	public List<Ann> regDatePage(Map<String, Integer> param) {
//		Connection conn = getConnection();
//		List<Ann> list = annDao.regDatePage(conn, param);
//		close(conn);
//		return list;
//	}
//
//	public List<Ann> findByTitle(Map<String, String> param) {
//		Connection conn = getConnection();
//		List<Ann> list = annDao.findByTitle(conn, param);
//		close(conn);
//		return list;
//	}

//	public List<Ann> endDatePage(Map<String, Integer> param) {
//		Connection conn = getConnection();
//		List<Ann> list = annDao.endDatePage(conn, param);
//		close(conn);
//		return list;
//	}

	public List<Ann> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Ann> list = annDao.findAll(conn, param);
		close(conn);
		return list;
	}
}
