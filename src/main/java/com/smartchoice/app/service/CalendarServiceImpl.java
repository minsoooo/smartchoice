package com.smartchoice.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.persistance.CalendarDAO;

@Service
public class CalendarServiceImpl implements CalendarService {
	@Inject
	private CalendarDAO dao;
	
	@Override
	public String getDate() {
		return dao.getDate();
	}

	@Override
	public int getNowYear(String year) {
		return dao.getNowYear(year);
	}

	@Override
	public int getNowMonth(String month) {
		return dao.getNowMonth(month);
	}

}
