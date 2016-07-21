package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CardDto;

public interface CardService {

	public List<CardDto> getCardList(int card_compnum);
	public void registerCard(CardDto dto);
	public List getCompanyList();
	public List getBigCategoryList();
	public List getSmallCategoryList();
	public List getDiscountList();
	public void deleteCard(int card_useflag);
	public List<CardDto> CardList();



}
