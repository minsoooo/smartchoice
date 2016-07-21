package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.CardDto;

public interface CardDAO {
	public void registerCard(CardDto dto);
	public List getBigCategoryList();
	public List getSmallCategoryList(int big_num);
	public List getDiscountList();
	public void updateCard(CardDto dto);
	public void deleteCard(int card_useflag);
	public List<CardDto> CardList();
	public List<CardDto> getCardComp();
	public List<CardDto> getCardList(int card_compnum);

}
