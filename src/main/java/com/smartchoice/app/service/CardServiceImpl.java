package com.smartchoice.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.persistance.CardDAO;

@Service
public class CardServiceImpl implements CardService {

	@Autowired
	private CardDAO dao;
	
	
	@Override
	public List<CardDto> getCardList(int card_compnum) {
		
		return dao.getCardList(card_compnum);
	}
	@Override
	public void registerCard(CardDto dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public List getCompanyList() {
		// TODO Auto-generated method stub
		return dao.getCompanyList();
	}

	@Override
	public List getBigCategoryList() {
		// TODO Auto-generated method stub
		return dao.getBigCategoryList();

	}

	@Override
	public List getSmallCategoryList() {
		// TODO Auto-generated method stub
		return dao.getSmallCategoryList();
	}

	@Override
	public List getDiscountList() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void deleteCard(int card_useflag) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<CardDto> CardList() {
		// TODO Auto-generated method stub
		return null;
	}

}