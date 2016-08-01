/*
 * 	카드추천 Bigclass
		
	작성일 : 2016-07-19
	수정일 : 2016-07-19
	작성자 : 김상덕
 */
package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.DiscountDto;


public interface DiscountDAO {
	public List<DiscountDto> getSmallSelect(int dc_smallnum, int card_typeflag);
	public List<DiscountDto> getDiscountName(String dc_cardcode);
}