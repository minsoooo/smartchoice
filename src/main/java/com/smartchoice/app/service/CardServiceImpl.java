package com.smartchoice.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.CardDiscountDto;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.persistance.CardDAO;

@Service
public class CardServiceImpl implements CardService {

	@Autowired
	private CardDAO dao;
	
	@Override
	public void registerCard(CardDto dto) {
		dao.registerCard(dto);

	}
	@Override
	public void registerCardDiscount(List<CardDiscountDto> disDto) {
		dao.registerCardDiscount(disDto);
		
	}

	@Override
	public List getBigCategoryList() {
		// TODO Auto-generated method stub
		return dao.getBigCategoryList();
	}

	@Override
	public List getSmallCategoryList(int big_num) {
		// TODO Auto-generated method stub
		return dao.getSmallCategoryList(big_num);
	}

	@Override
	public void updateCard(CardDto dto) {
		dao.updateCard(dto);

	}

	@Override
	public void deleteCard(String card_code) {
		dao.deleteCard(card_code);

	}	
	@Override
	public List<CardDto> getCardList(int card_compnum) {
		
		return dao.getCardList(card_compnum);
	}

	@Override
	public List<CardDto> CardList() {
		return dao.CardList();
	}
	@Override
	public List<CardDto> getCardComp() {

		return dao.getCardComp();
	}

	@Override
	public List<CardDiscountDto> getDiscountList() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int getCard_num() {
		return dao.getCard_num();
	}
	@Override
	public void updateCardImage(CardDto dto) {
		System.out.println("서비스임플:"+dto);
		dao.updateCardImage(dto);
		
	}
	@Override
	public CardDto getCard_info(String card_code) {
		return dao.getCard_info(card_code);
	}
	@Override
	public List<CardDiscountDto> getDisCard_info(String card_code) {
		return dao.getDisCard_info(card_code);
	}
	@Override
	public void deleteDisCard(List<CardDiscountDto> disDto) {
		
		dao.deleteDisCard(disDto);
		
	}
	@Override
	public void updateDisCard(List<CardDiscountDto> disDto) {
		dao.updateDisCard(disDto);
		
	}


}
