package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
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
		
		return sqlSession.selectOne(NAMESPACE+".getManager",params);
	}

	@Override
	public ManagerDto getMngWithId(String mng_id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mng_id", mng_id);
		return sqlSession.selectOne(NAMESPACE+".getManager",params);
	}

	@Override
	public List<ManagerDto> getManager() {
		return sqlSession.selectList(NAMESPACE+".getManager");
	}

	@Override
	public void regiManager(ManagerDto dto) {
		sqlSession.insert(NAMESPACE+".regiManager",dto);
		
	}

	@Override
	public void updateManager(ManagerDto dto) {
		sqlSession.update(NAMESPACE +".updateManager", dto);
		
	}

	@Override
	public void delManager(String mng_id) {
		sqlSession.delete(NAMESPACE+".delManager",mng_id);
		

	}

}
