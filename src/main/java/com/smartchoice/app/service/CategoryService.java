package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CategoryDto;

public interface CategoryService {
	public List<CategoryDto> getAllSmallCategory();
	public List<CategoryDto> getSmallCategory(Integer big_num) throws Exception;
	public CategoryDto getCategoryName(int small_num);
	
	public void insertSmallCategory(String small_bignum, String small_name);	//소분류 추가 160804_by.santori
	public void insertBigCategory(String big_name);								//대분류 추가 160804_by.santori
	public void updateSmallCategory(String small_name, String  small_num);		//소분류 수정 160804_by.santori
	public void updateBigCategory(String big_name, String big_num);				//대분류 수정 160804_by.santori
}
