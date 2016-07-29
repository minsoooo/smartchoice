package com.smartchoice.app.persistance;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.CardDiscountDto;
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
	public void registerCard(CardDto dto) {
		sqlSession.insert(NAMESPACE+".registerCard",dto);
		
	}
	@Override
	public void registerCardDiscount(List<CardDiscountDto> disDto) {

		for(int i=0; i<disDto.size(); i++){
			sqlSession.insert(NAMESPACE+".registerCardDiscount",disDto.get(i));
			System.out.println(disDto.get(i));
		}
	}

	@Override
	public void updateCard(CardDto dto) {

	}

	@Override
	public List<CardDto> getCardComp() {

		return sqlSession.selectList(NAMESPACE+".getCardComp");
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
	public void deleteCard(int card_useflag) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<CardDto> CardList() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void getDiscountList(CardDiscountDto disDto) {
		sqlSession.insert(NAMESPACE + ".getCardDiscountList", disDto);
	}


	@Override
	public int getCard_num() {
		
		return sqlSession.selectOne(NAMESPACE + ".getCard_num");
	}


	@Override
	public void updateCardImage(CardDto dto) {
		System.out.println(dto);
		sqlSession.insert(NAMESPACE + ".updateCardImage", dto);
		
	}




}


