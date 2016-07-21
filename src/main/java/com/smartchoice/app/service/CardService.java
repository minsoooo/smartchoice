package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CardDto;

public interface CardService {
<<<<<<< HEAD
	public void registerCard(CardDto dto);
	public List getCompanyList();
	public List getBigCategoryList();
	public List getSmallCategoryList(int big_num);
	public List getDiscountList();
	public void updateCard(CardDto dto);
	public void deleteCard(int card_useflag);
	public List<CardDto> CardList();
	public List<CardDto> getCardComp();
	public List<CardDto> getCardList(int card_compnum);

=======
	public void insertCard(CardDto dto);
	public void updateCard(CardDto dto);
>>>>>>> refs/remotes/origin/master
}
