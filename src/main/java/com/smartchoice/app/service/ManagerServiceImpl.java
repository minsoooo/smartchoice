package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.ManagerDto;
import com.smartchoice.app.persistance.ManagerDAO;

@Service
public class ManagerServiceImpl implements ManagerService {
	@Inject
	private ManagerDAO dao;
	
	@Override
	public ManagerDto getMngWithIdAndPw(String mng_id, String mng_pw) {

		return dao.getMngWithIdAndPw(mng_id, mng_pw);
	}

	@Override
	public ManagerDto getMngWithId(String mng_id) {	
		return dao.getMngWithId(mng_id);
	}

	@Override
	public List<ManagerDto> getManager() {
		
		return dao.getManager();
	}

	@Override
	public void regiManager(ManagerDto dto) {
		dao.regiManager(dto);
		
	}

	@Override
	public void updateManager(ManagerDto dto) {
		dao.updateManager(dto);
		
	}

	@Override
	public void delManager(String mng_id) {
		dao.delManager(mng_id);
		
	}

}
