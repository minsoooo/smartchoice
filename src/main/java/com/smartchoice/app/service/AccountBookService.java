package com.smartchoice.app.service;

import java.util.List;
import java.util.Map;

import com.smartchoice.app.domain.AccountBookDto;
import com.smartchoice.app.domain.CategoryDto;

public interface AccountBookService {
	public void deleteAccountBook(int regi_num);
	public void insertRegiAbook(String regi_month, String regi_day, int regi_memnum);
	public int selectRegiNum(String regi_month, String regi_day, int regi_memnum);
	public void insertAccountBook(Map<String, Object> map);
	public List<String> selectRegiDay(String regi_month, int regi_memnum);
	public List<AccountBookDto> getAccountBook(int abook_reginum);
	public void deleteRegiAbook(String regi_month, String regi_day, int regi_memnum);
	public List<Integer> getTotalMoney(int regi_memnum, String regi_month); 
	public List<AccountBookDto> getAccountBookList();
}
