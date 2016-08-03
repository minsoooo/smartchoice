package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.StatsDto;

@Repository
public class StatsDAOImpl implements StatsDAO {
	private static final String NAMESPACE ="com.smartchoice.mappers.statsMapper";
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List getSmallNums(String regi_month, int regi_memnum) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("regi_month", regi_month);
		paramMap.put("regi_memnum", regi_memnum);
		
		return sqlSession.selectList(NAMESPACE + ".getSmallNums", paramMap);
	}

	@Override
	public List getMoneyList(String regi_month, int regi_memnum, int small_num) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("regi_month", regi_month);
		paramMap.put("regi_memnum", regi_memnum);
		paramMap.put("small_num", small_num);
		
		return sqlSession.selectList(NAMESPACE + ".getMoneyList", paramMap);
	}

	@Override
	public StatsDto getStatsResult(int small_num) {
		return sqlSession.selectOne(NAMESPACE + ".getStatsResult", small_num);
	}
}
