package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.DiscountDto;


@Repository
public class DiscountDAOImpl implements DiscountDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.smartchoice.mappers.discountMapper";

	@Override
	public List<DiscountDto> getSmallSelect(int dc_smallnum, int card_typeflag) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dc_smallnum", dc_smallnum);
		paramMap.put("card_typeflag", card_typeflag);
		return sqlSession.selectList(NAMESPACE + ".getSmallSelect", paramMap);
	}

	@Override
	public List<DiscountDto> getDiscountName(String dc_cardcode) {
		return sqlSession.selectList(NAMESPACE + ".getDiscountName", dc_cardcode);
	}
	@Override
	public List<DiscountDto> getCardDCInfo(String card_code) {
		return sqlSession.selectList(NAMESPACE + ".getCardDCInfo", card_code);
	}	
}