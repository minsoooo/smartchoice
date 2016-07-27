package com.smartchoice.app.service;

import com.smartchoice.app.domain.ManagerDto;

public interface ManagerService {
	public ManagerDto getMngWithIdAndPw(String mng_id, String mng_pw);
}
