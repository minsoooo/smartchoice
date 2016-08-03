package com.smartchoice.app.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.AccountBookDto;
import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.persistance.AccountBookDAO;

@Service
public class AccountBookServiceImpl implements AccountBookService {
	@Inject
	private AccountBookDAO dao;
	
	@Override
	public void insertRegiAbook(String regi_month, String regi_day, int regi_memnum) {
		dao.insertRegiAbook(regi_month, regi_day, regi_memnum);
	}

	@Override
	public int selectRegiNum(String regi_month, String regi_day, int regi_memnum) {
		return dao.selectRegiNum(regi_month, regi_day, regi_memnum);
	}

	@Override
	public void insertAccountBook(Map<String, Object> map) {
		dao.insertAccountBook(map);
	}

	@Override
	public List<String> selectRegiDay(String regi_month, int regi_memnum) {
		return dao.selectRegiDay(regi_month, regi_memnum);
	}

	@Override
	public List<AccountBookDto> getAccountBook(int abook_reginum) {
		return dao.getAccountBook(abook_reginum);
	}
	@Override
	public void deleteAccountBook(int regi_num) {
		dao.deleteAccountBook(regi_num);
		
	}

	@Override
	public void deleteRegiAbook(String regi_month, String regi_day, int regi_memnum) {
		dao.deleteRegiAbook(regi_month, regi_day, regi_memnum);
		
	}

	@Override
	public List<Integer> getTotalMoney(int regi_memnum, String regi_month) {
		return dao.getTotalMoney(regi_memnum, regi_month);
	}
	
	public List<AccountBookDto> getAccountBookList() {
		return dao.getAccountBookList();

	}
}
