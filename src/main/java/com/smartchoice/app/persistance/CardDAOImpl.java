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
	public void insertCard(CardDto dto) {

	}

	@Override
	public void updateCard(CardDto dto) {

	}

	@Override
	public List<CardDto> getCardComp() {

		return sqlSession.selectList(NAMESPACE+".getCardComp");
	}


}
