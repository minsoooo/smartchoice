package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.ManagerDto;

@Repository
public class ManagerDAOImpl implements ManagerDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE ="com.smartchoice.mappers.managerMapper";
	
	@Override
	public ManagerDto getMngWithIdAndPw(String mng_id, String mng_pw) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mng_id", mng_id);
		params.put("mng_pw", mng_pw);
		
		return sqlSession.selectOne(NAMESPACE+".getMngWithIdAndPw",params);
	}

}
