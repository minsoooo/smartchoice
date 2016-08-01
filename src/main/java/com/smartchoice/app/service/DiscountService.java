package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.DiscountDto;


public interface DiscountService {
	public List<DiscountDto> getSmallSelect(int dc_smallnum, int card_typeflag);
	public List<DiscountDto> getDiscountName(String dc_cardcode);
}