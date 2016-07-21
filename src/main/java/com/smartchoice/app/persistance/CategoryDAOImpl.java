package com.smartchoice.app.persistance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CategoryDto;

@Repository
public class CategoryDAOImpl implements CategoryDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.smartchoice.mappers.categoryMapper";
	
	@Override
	public List<CategoryDto> getAllSmallCategory() {
		return sqlSession.selectList(NAMESPACE + ".getAllSmallCategory");
	}

	@Override
	public List<CategoryDto> getSmallCategory(Integer big_num) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getSmallCategory", big_num);
	}

}
