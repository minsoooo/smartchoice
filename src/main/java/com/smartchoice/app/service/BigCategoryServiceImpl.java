package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.persistance.BigCategoryDAO;

@Service
public class BigCategoryServiceImpl implements BigCategoryService {
	@Inject
	private BigCategoryDAO dao;
	
	@Override
	public List<BigCategoryDto> getBigCategory() {
		return dao.getBigCategory();
	}

	@Override
	public BigCategoryDto getBigCateWithNum(int big_num) {
		return dao.getBigCateWithNum(big_num);
	}

}
