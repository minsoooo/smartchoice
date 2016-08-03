package com.smartchoice.app.service;

import java.util.List;


import com.smartchoice.app.domain.BigCategoryDto;

public interface BigCategoryService {
	public List<BigCategoryDto> getBigCategory();
	public List<BigCategoryDto> getDcBigCategory(String dc_cardcode);
	public BigCategoryDto getBigCateWithNum(int big_num);
}
