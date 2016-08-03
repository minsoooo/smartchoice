package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.BigCategoryDto;

@Repository
public class BigCategoryDAOImpl implements BigCategoryDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.smartchoice.mappers.bigcategoryMapper";
	
	@Override
	public List<BigCategoryDto> getBigCategory() {
		return sqlSession.selectList(NAMESPACE + ".readBigCategory");
	}

	@Override
	public BigCategoryDto getBigCateWithNum(int big_num) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("big_num", big_num);
		return sqlSession.selectOne(NAMESPACE + ".readBigCategory",param);
	}

	@Override
	public List<BigCategoryDto> getDcBigCategory(String dc_cardcode) {
		return sqlSession.selectList(NAMESPACE + ".readDcBigCategory", dc_cardcode);
	}
	
}
