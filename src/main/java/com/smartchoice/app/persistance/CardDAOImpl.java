package com.smartchoice.app.persistance;

import java.util.List;


import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.CardDto;
@Repository
public class CardDAOImpl implements CardDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.smartchoice.mappers.cardMapper";
	
	@Override
	public List<CardDto> getCardList(int card_compnum) {
		
		return sqlSession.selectList(NAMESPACE+".getCardList",card_compnum);
	}


	@Override
	public void updateCard(CardDto dto) {

	}

	@Override
	public List<CardDto> getCardComp() {

		return sqlSession.selectList(NAMESPACE+".getCardComp");
	}


	@Override
	public void registerCard(CardDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List getBigCategoryList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".getBigCategoryList");
	}


	@Override
	public List getSmallCategoryList(int big_num) {
		// TODO Auto-generated method stub

		return sqlSession.selectList(NAMESPACE+".getSmallCategoryList",big_num);
	}


	@Override
	public List getDiscountList() {
		// TODO Auto-generated method stub
		return null;
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


	@Override


	public CardDto getCardName(String card_code) {
		return sqlSession.selectOne(NAMESPACE + ".getCardName", card_code);
	}
	public String getCardCompName(int comp_num) {
		
		return sqlSession.selectOne(NAMESPACE+".getCardCompName", comp_num);

	}

	@Override
	public String getCompName(String card_code) {
		return sqlSession.selectOne(NAMESPACE+".getCompName", card_code);
	}

}


