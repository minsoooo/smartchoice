package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.StatsDto;

public interface StatsDAO {
	public List getSmallNums(String regi_month, int regi_memnum);
	public List getMoneyList(String regi_month, int regi_memnum, int small_num);
	public StatsDto getStatsResult(int small_num);
}
