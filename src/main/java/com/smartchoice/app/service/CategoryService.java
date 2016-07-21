package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CategoryDto;

public interface CategoryService {
	public List<CategoryDto> getAllSmallCategory();
	public List<CategoryDto> getSmallCategory(Integer big_num) throws Exception;
}
