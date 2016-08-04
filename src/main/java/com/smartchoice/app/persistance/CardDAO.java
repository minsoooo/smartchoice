package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.CardDiscountDto;
import com.smartchoice.app.domain.CardDto;


public interface CardDAO {
	public List<CardDto> getCardList(int card_compnum);
	public void registerCard(CardDto dto);
	public void registerCardDiscount(List<CardDiscountDto> disDto);
	public List getBigCategoryList();
	public List getSmallCategoryList(int big_num);
	public void getDiscountList(CardDiscountDto disDto);
	public void updateCard(CardDto dto);
	public void updateCardImage(CardDto dto);
	public void deleteCard(String card_code);
	public void deleteDisCard(List<CardDiscountDto> disDto);
	public void updateDisCard(List<CardDiscountDto> disDto);
	public List<CardDto> CardList();
	public List<CardDto> getCardComp();
	public int getCard_num();
	public CardDto getCard_info(String card_code);
	public List<CardDiscountDto> getDisCard_info(String card_code);


}
