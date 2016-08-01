package com.smartchoice.app.util;

import java.util.Calendar;

import com.smartchoice.app.domain.CalendarDto;

public class CalendarUtil {
	public static final int START_DATE = 1;
	Calendar cal = Calendar.getInstance();
	StringBuilder today = new StringBuilder();
	int now_year = 0;
	int now_month = 0;
	int now_day = cal.get(Calendar.DAY_OF_MONTH);
	
	public String getDate() {
		CalendarDto dto = new CalendarDto();
		String param_month = dto.getMonth();
		String param_year = dto.getYear();
		StringBuilder param_day = new StringBuilder();

		today.append(cal.get(Calendar.YEAR)).append(cal.get(Calendar.MONTH) + 1);
		cal.set(Calendar.DAY_OF_MONTH, 1);

		if (param_month != null) {
			cal.set(Calendar.MONTH, Integer.parseInt(param_month) - 1);
		}
		
		now_month = cal.get(Calendar.MONTH) + 1;

		if (param_year != null) {
			cal.set(Calendar.YEAR, Integer.parseInt(param_year));
		}

		now_year = cal.get(Calendar.YEAR);

		param_day.append(now_year).append(now_month);

		return param_day.toString();
	}

	public int getNowYear(String year) {
		if (year != null && year != "") {
			cal.set(Calendar.YEAR, Integer.parseInt(year));
		}
		else{
			cal.set(Calendar.YEAR, 2016);
		}

		now_year = cal.get(Calendar.YEAR);
		
		return now_year;
	}

	public int getNowMonth(String month) {
		if (month != null && month != "") {
			cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
		}
		else{
			cal.set(Calendar.MONTH, Calendar.DAY_OF_MONTH+1);
		}
		
		now_month = cal.get(Calendar.MONTH)+1;
	
		return now_month;
	}
}
