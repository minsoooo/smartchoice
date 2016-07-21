package com.smartchoice.app.persistance;

import java.util.List;

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
	
}
