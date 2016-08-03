package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.CardDto;



public interface CardDAO {
	public List<CardDto> getCardList(int card_compnum);
	public void registerCard(CardDto dto);
	public List getBigCategoryList();
	public List getSmallCategoryList(int big_num);
	public List getDiscountList();
	public void updateCard(CardDto dto);
	public void deleteCard(int card_useflag);
	public List<CardDto> CardList();
	public List<CardDto> getCardComp();
	public CardDto getCardName(String card_code);
	//카드네임만 가져오기/ by minsoo
	public String getCardCompName(int comp_num);
	public String getCompName(String card_code);
	public CardDto getCard(String card_code); //카드코드로 정보 가져오기 by.Santori

}
