package com.smartchoice.app.persistance;

public interface CalendarDAO {
	public String getDate();
	public int getNowYear(String year);
	public int getNowMonth(String month);
}
