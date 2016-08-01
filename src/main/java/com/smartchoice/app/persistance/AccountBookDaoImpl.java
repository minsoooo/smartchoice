package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.Session;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.AccountBookDto;
import com.smartchoice.app.domain.CategoryDto;

@Repository
public class AccountBookDaoImpl implements AccountBookDAO {
	private static final String NAMESPACE ="com.smartchoice.mappers.accountbookMapper";
	@Inject
	private SqlSession sqlSession;
	
	
	@Override
	public void deleteAccountBook(int regi_num) {
		sqlSession.delete(NAMESPACE + ".deleteAccountBook", regi_num);	
	}
	
	@Override
	public void insertRegiAbook(String regi_month, String regi_day, int regi_memnum) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("regi_month", regi_month);
		paramMap.put("regi_day", regi_day);
		paramMap.put("regi_memnum", regi_memnum);
		
		sqlSession.insert(NAMESPACE +".insertRegiAbook", paramMap);	
	}

	@Override
	public int selectRegiNum(String regi_month, String regi_day, int regi_memnum) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("regi_month", regi_month);
		paramMap.put("regi_day", regi_day);
		paramMap.put("regi_memnum", regi_memnum);
		
		return sqlSession.selectOne(NAMESPACE + ".selectRegiNum", paramMap);
	}

	@Override
	public void insertAccountBook(Map<String, Object> map) {
		sqlSession.insert(NAMESPACE + ".insertAccountBook", map);
	}

	@Override
	public List<String> selectRegiDay(String regi_month, int regi_memnum) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("regi_month", regi_month);
		paramMap.put("regi_memnum", regi_memnum);
		
		return sqlSession.selectList(NAMESPACE + ".selectRegiDay", paramMap);
	}

	@Override
	public List<AccountBookDto> getAccountBook(int abook_reginum) {
		return sqlSession.selectList(NAMESPACE + ".getAccountBook", abook_reginum);
	}

	
	@Override
	public void deleteRegiAbook(String regi_month, String regi_day, int regi_memnum) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("regi_month", regi_month);
		paramMap.put("regi_day", regi_day);
		paramMap.put("regi_memnum", regi_memnum);
		sqlSession.delete(NAMESPACE + ".deleteRegiABook", paramMap);
	}

}
