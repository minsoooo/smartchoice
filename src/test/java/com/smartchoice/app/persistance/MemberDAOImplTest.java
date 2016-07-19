package com.smartchoice.app.persistance;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.service.MemberService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class MemberDAOImplTest {
	
	private static Logger logger = LoggerFactory.getLogger(MemberDAOImplTest.class);
	
	@Inject
	private MemberService service;
	
	@Ignore
	@Test
	public void testRegiMember() {	
		MemberDto dto = new MemberDto();
		dto.setMem_email("ccc@ccc");
		dto.setMem_fav1("123");
		dto.setMem_fav2("123");
		dto.setMem_fav3("123");
		dto.setMem_level("2");
		dto.setMem_pw("1111");
		dto.setMem_cardnum("1111");
		logger.info(dto.toString());
		
		service.regiMember(dto);
	}
	
	@Ignore
	@Test
	public void testGetMemberList() throws Exception {
		List list = new ArrayList();
		list = service.getMemberList();
		logger.info(Integer.toString(list.size()));
		
	}
	@Test
	public void testGetMember() throws Exception{
		MemberDto dto = new MemberDto();
		dto = service.getMember("alstn", "1234567");
		logger.info(dto.toString());
	}
	
	@Ignore
	@Test
	public void testUpdateMember() throws Exception {
		MemberDto dto = new MemberDto();
		dto.setMem_fav1("수정테스트");
		dto.setMem_fav2("수정테스트");
		dto.setMem_fav3("수정테스트");
		dto.setMem_level("수정테스트");
		dto.setMem_pw("수정테스트");
		dto.setMem_cardnum("수정테스트");
		dto.setMem_num(1);
		
		service.updateMember(dto);
	}
	
	@Test
	public void testDeleteMember() throws Exception {
		service.deleteMember(1);
	}

}