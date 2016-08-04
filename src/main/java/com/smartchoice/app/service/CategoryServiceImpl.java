package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.persistance.CategoryDAO;


@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Inject
	private CategoryDAO dao;
	
	@Override
	public List<CategoryDto> getAllSmallCategory() {
		return dao.getAllSmallCategory();
	}

	@Override
	public List<CategoryDto> getSmallCategory(Integer big_num) throws Exception {
		return dao.getSmallCategory(big_num);
	}

	@Override
	public CategoryDto getCategoryName(int small_num) {
		return dao.getCategoryName(small_num);
	}

	@Override
	public void insertSmallCategory(String small_bignum, String small_name) {//소분류 추가 160804_by.santori
		dao.insertSmallCategory(small_bignum, small_name);
	}

	@Override
	public void insertBigCategory(String big_name) {//대분류 추가 160804_by.santori
		dao.insertBigCategory(big_name);
	}

	@Override
	public void updateSmallCategory(String small_name, String small_num) {//소분류 수정 160804_by.santori
		dao.updateSmallCategory(small_name, small_num);
	}

	@Override
	public void updateBigCategory(String big_name, String big_num) {//대분류 수정 160804_by.santori
		dao.updateBigCategory(big_name, big_num);
	}
}
