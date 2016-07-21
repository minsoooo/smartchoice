package com.smartchoice.app.persistance;

public interface CalendarDao {
	public String getDate();
	public int getNowYear(String year);
	public int getNowMonth(String month);
}
