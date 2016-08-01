package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.StatsDto;
import com.smartchoice.app.persistance.StatsDAO;

@Service
public class StatsServiceImpl implements StatsService {
	@Inject
	private StatsDAO dao;

	@Override
	public List getSmallNums(String regi_month, int regi_memnum) {
		return dao.getSmallNums(regi_month, regi_memnum);
	}

	@Override
	public List getMoneyList(String regi_month, int regi_memnum, int small_num) {
		return dao.getMoneyList(regi_month, regi_memnum, small_num);
	}

	@Override
	public StatsDto getStatsResult(int small_num) {
		return dao.getStatsResult(small_num);
	}

}
