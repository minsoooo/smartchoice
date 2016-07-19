package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.persistance.BigCategoryDao;

@Service
public class BigCategoryServiceImpl implements BigCategoryService {
	@Inject
	private BigCategoryDao dao;
	
	@Override
	public List<BigCategoryDto> getBigCategory() {
		return dao.getBigCategory();
	}

}
