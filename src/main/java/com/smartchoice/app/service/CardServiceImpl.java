package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.persistance.CardDao;
@Service
public class CardServiceImpl implements CardService {
	
	@Inject
	private CardDao dao;
	
	@Override
	public List<CardDto> getCardList(int card_compnum) {
		
		return dao.getCardList(card_compnum);
	}

	@Override
	public void insertCard(CardDto dto) {
		dao.insertCard(dto);
	}

	@Override
	public void updateCard(CardDto dto) {
		dao.updateCard(dto);
	}

	@Override
	public List<CardDto> getCardComp() {

		return dao.getCardComp();
	}

}
