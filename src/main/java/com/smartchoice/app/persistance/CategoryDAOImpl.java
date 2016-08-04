package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public CategoryDto getCategoryName(int small_num) {
		return sqlSession.selectOne(NAMESPACE + ".getCategoryName", small_num);
	}
	

	@Override
	public void insertSmallCategory(String small_bignum, String small_name) {//소분류 추가 160804_by.santori
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("small_bignum", small_bignum);
		paramMap.put("small_name", small_name);
		System.out.println("---------------------------"+small_bignum+"  ,  "+small_name);
		sqlSession.insert(NAMESPACE + ".insertSmallCategory", paramMap);
	}

	@Override
	public void insertBigCategory(String big_name) {//대분류 추가 160804_by.santori
		sqlSession.insert(NAMESPACE + ".insertBigCategory", big_name);
	}

	@Override
	public void updateSmallCategory(String small_name, String small_num) {//소분류 수정 160804_by.santori
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("small_name", small_name);
		paramMap.put("small_num", small_num);
		
		sqlSession.update(NAMESPACE + ".updateSmallCategory", paramMap);
	}

	@Override
	public void updateBigCategory(String big_name, String big_num) {//대분류 수정 160804_by.santori
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("big_name", big_name);
		paramMap.put("big_num", big_num);
		
		sqlSession.update(NAMESPACE + ".updateBigCategory", paramMap);
	}
}
