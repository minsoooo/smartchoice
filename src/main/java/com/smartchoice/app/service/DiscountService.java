package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.DiscountDto;



public interface DiscountService {
	public List<DiscountDto> getSmallSelect(int dc_smallnum, int card_typeflag);
	public List<DiscountDto> getDiscountName(String dc_cardcode);
	public DiscountDto getCardDCInfo(String card_code, int small_num);
	public List<DiscountDto> getAllCardDCInfo(int small_num);
	public List<DiscountDto> getAllCardDCInfo(String card_code);
	public List<DiscountDto> getDiscountDetail(String dc_cardcode);
	public List<DiscountDto> getDcBigCategory(String dc_cardcode);
	public List<DiscountDto> getDcSmallCategory(String dc_cardcode, int small_bignum);
}
