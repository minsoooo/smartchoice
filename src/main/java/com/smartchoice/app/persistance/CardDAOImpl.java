package com.smartchoice.app.persistance;

import java.util.List;

import javax.inject.Inject;


import org.apache.ibatis.session.SqlSession;

import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.CardDto;


@Repository
public class CardDAOImpl implements CardDAO {
	
	private static final String NAMESPACE = "com.smartchoice.mappers.cardMapper";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void registerCard(CardDto dto) {
		// TODO Auto-generated method stub

	}
	
	public List<CardDto> getCardList(int card_compnum) {
		
		return sqlSession.selectList(NAMESPACE+".getCardList",card_compnum);
	}
	@Override
	public List getCompanyList() {
		// TODO 카드사 리스트
		return sqlSession.selectList(NAMESPACE+".getCompanyList");
	}

	@Override
	public List getBigCategoryList() {
		// TODO 대분류 카테고리
		return sqlSession.selectList("getBigCategoryList");
	}

	@Override
	public List getSmallCategoryList() {
		// TODO 소분류 카테고리
		return sqlSession.selectList("getSmallCategoryList");
	}

	@Override
	public List getDiscountList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateCard(CardDto dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteCard(int card_useflag) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<CardDto> CardList() {
		// TODO Auto-generated method stub
		return null;
	}

}




