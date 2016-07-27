package com.smartchoice.app.service;

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

}
