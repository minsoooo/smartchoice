package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CardDiscountDto;
import com.smartchoice.app.domain.CardDto;


public interface CardService {

	public void registerCard(CardDto dto);	//카드등록
	public void registerCardDiscount(List<CardDiscountDto> disDto);
	public int getCard_num();
	public CardDto getCard_info(String card_code);
	public List<CardDiscountDto> getDisCard_info(String card_code);
	public List getBigCategoryList();
	public List getSmallCategoryList(int big_num);
	public List<CardDiscountDto> getDiscountList();
	public void updateCard(CardDto dto);
	public void updateCardImage(CardDto dto);
	public void deleteCard(String card_code);
	public void deleteDisCard(List<CardDiscountDto> disDto);
	public void updateDisCard(List<CardDiscountDto> disDto);
	public List<CardDto> CardList();
	public List<CardDto> getCardComp();
	public List<CardDto> getCardList(int card_compnum);



}
