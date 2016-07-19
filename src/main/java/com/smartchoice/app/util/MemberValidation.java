package com.smartchoice.app.util;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.smartchoice.app.domain.MemberDto;



public class MemberValidation implements Validator {
	

	
	@Override
	public boolean supports(Class<?> arg0) {

		return MemberDto.class.isAssignableFrom(arg0);
	}

	@Override
	public void validate(Object arg0, Errors arg1) {
		MemberDto dto = (MemberDto) arg0;
		
		if (dto.getMem_id() == null || dto.getMem_id().trim().toString().isEmpty()) {
			arg1.rejectValue("mem_id", "required");
		}

		if (dto.getMem_pw() == null || dto.getMem_pw().trim().toString().isEmpty()) {
			arg1.rejectValue("mem_pw", "required");
			
		}

		
	}

}
