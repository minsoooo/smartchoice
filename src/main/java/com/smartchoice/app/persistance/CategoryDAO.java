/*
 * 	대분류 소분류 DAO interface
		
	작성일 : 2016-07-21
	수정일 : 2016-07-21
	작성자 : 김상덕
 */
package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.CategoryDto;

public interface CategoryDAO {
	public List<CategoryDto> getAllSmallCategory();
	public List<CategoryDto> getSmallCategory(Integer big_num) throws Exception;
	public CategoryDto getCategoryName(int small_num);

}
