package com.smartchoice.app.persistance;

import com.smartchoice.app.domain.ManagerDto;

public interface ManagerDAO {
	public ManagerDto getMngWithIdAndPw(String mng_id, String mng_pw);
}
