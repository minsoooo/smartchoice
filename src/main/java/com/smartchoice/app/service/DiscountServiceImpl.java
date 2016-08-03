package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.DiscountDto;
import com.smartchoice.app.persistance.DiscountDAO;

@Service
public class DiscountServiceImpl implements DiscountService {
	@Inject
	private DiscountDAO dao;

	@Override
	public List<DiscountDto> getSmallSelect(int dc_smallnum, int card_typeflag) {
		return dao.getSmallSelect(dc_smallnum, card_typeflag);
	}

	@Override
	public List<DiscountDto> getDiscountName(String dc_cardcode) {
		return dao.getDiscountName(dc_cardcode);
	}
	@Override
	public DiscountDto getCardDCInfo(String card_code, int small_num) {
		return dao.getCardDCInfo(card_code, small_num);
	}

	@Override
	public List<DiscountDto> getAllCardDCInfo(int small_num) {
		return dao.getAllCardDCInfo(small_num);
	}

	@Override
	public List<DiscountDto> getAllCardDCInfo(String card_code) {
		return dao.getAllCardDCInfo(card_code);
	}
	
	@Override
	public List<DiscountDto> getDiscountDetail(String dc_cardcode) {
		// TODO Auto-generated method stub
		return dao.getDiscountDetail(dc_cardcode);
	}
	
	@Override
	public List<DiscountDto> getDcBigCategory(String dc_cardcode) {
		return dao.getDcBigCategory(dc_cardcode);
	}
	
	@Override
	public List<DiscountDto> getDcSmallCategory(String dc_cardcode, int small_bignum) {
		return dao.getDcSmallCategory(dc_cardcode, small_bignum);
	}
}

