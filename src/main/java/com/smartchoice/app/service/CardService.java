package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.CardDto;

public interface CardService {
	public List<CardDto> getCardComp();
	public List<CardDto> getCardList(int card_compnum);
	public void insertCard(CardDto dto);
	public void updateCard(CardDto dto);
}
