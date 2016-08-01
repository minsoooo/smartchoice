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
	
	

}