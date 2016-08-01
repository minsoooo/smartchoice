package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.ManagerDto;

public interface ManagerDAO {
	public ManagerDto getMngWithIdAndPw(String mng_id, String mng_pw);
	public ManagerDto getMngWithId(String mng_id);
	public List<ManagerDto> getManager();
	public void regiManager(ManagerDto dto);
	public void updateManager(ManagerDto dto);
	public void delManager(String mng_id);
}
