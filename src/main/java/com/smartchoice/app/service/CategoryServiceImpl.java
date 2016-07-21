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

}
