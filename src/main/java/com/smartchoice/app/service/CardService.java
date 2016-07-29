package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CardDiscountDto;
import com.smartchoice.app.domain.CardDto;


public interface CardService {

	public void registerCard(CardDto dto);	//카드등록
	public void registerCardDiscount(List<CardDiscountDto> disDto);
	public int getCard_num();
	public List getBigCategoryList();
	public List getSmallCategoryList(int big_num);
	public List<CardDiscountDto> getDiscountList();
	public void updateCard(CardDto dto);
	public void updateCardImage(CardDto dto);
	public void deleteCard(int card_useflag);
	public List<CardDto> CardList();
	public List<CardDto> getCardComp();
	public List<CardDto> getCardList(int card_compnum);


}
