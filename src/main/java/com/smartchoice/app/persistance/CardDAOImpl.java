package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	

	//카드등록 : 카드기본정보 DB저장
	@Override
	public void registerCard(CardDto dto) {
		sqlSession.insert(NAMESPACE+".registerCard",dto);
		
	}
	
	//카드등록 : 카드할인정보 DB저장
	@Override
	public void registerCardDiscount(List<CardDiscountDto> disDto) {

		for(int i=0; i<disDto.size(); i++){
			sqlSession.insert(NAMESPACE+".registerCardDiscount",disDto.get(i));
			System.out.println(disDto.get(i));
		}
	}

	@Override
	public void updateCard(CardDto dto) {
		sqlSession.update(NAMESPACE+".updateCard", dto);
	}
	
	//카드등록 : 카드사 리스트 GET
	@Override
	public List<CardDto> getCardComp() {
		return sqlSession.selectList(NAMESPACE+".getCardComp");
	}
	
	//카드등록 : 대분류 리스트 GET
	@Override
	public List getBigCategoryList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE+".getBigCategoryList");
	}

	//카드등록 : 소분류 리스트 GET
	@Override
	public List getSmallCategoryList(int big_num) {
		return sqlSession.selectList(NAMESPACE+".getSmallCategoryList",big_num);
	}

	@Override
	public void deleteCard(String card_code) {
		sqlSession.update(NAMESPACE+".deleteCard",card_code);
		
	}

	//카드관리 : 카드리스트 페이지
	@Override
	public List<CardDto> CardList() {
		return sqlSession.selectList(NAMESPACE+".CardList");
	}

	// ?? 누가작성 ??
	@Override
	public void getDiscountList(CardDiscountDto disDto) {
		sqlSession.insert(NAMESPACE + ".getCardDiscountList", disDto);
	}
	
	//카드등록 : 카드코드화에 필요한 카드넘버 GET
	@Override
	public int getCard_num() {
		return sqlSession.selectOne(NAMESPACE + ".getCard_num");
	}

	//카드등록 : 카드 이미지 업데이트
	@Override
	public void updateCardImage(CardDto dto) {
		System.out.println(dto);
		sqlSession.insert(NAMESPACE + ".updateCardImage", dto);
		
	}

	@Override
	public CardDto getCard_info(String card_code) {
		return sqlSession.selectOne(NAMESPACE+".getCard_info", card_code);
	}


	@Override
	public List<CardDiscountDto> getDisCard_info(String card_code) {
		return sqlSession.selectList(NAMESPACE+".getDisCard_info", card_code);
	}


	@Override
	public void deleteDisCard(List<CardDiscountDto> disDto) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("dc_num", disDto.get(0).getDc_num());
		params.put("dc_cardcode", disDto.get(0).getDc_cardcode());
		System.out.println(disDto.get(0).getDc_smallnum()+":"+disDto.get(0).getDc_cardcode());
		sqlSession.delete(NAMESPACE+".deleteDisCard", params);			

	}


	@Override
	public void updateDisCard(List<CardDiscountDto> disDto) {
		for(int i=0; i<disDto.size(); i++){
			sqlSession.update(NAMESPACE+".updateDisCard", disDto.get(i));
			System.out.println(disDto.get(i));
		}
		
	}




}


