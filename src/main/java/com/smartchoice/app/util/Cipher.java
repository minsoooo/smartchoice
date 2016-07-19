package com.smartchoice.app.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class Cipher {
	private Random ran ;
	private String passMD5;
	private String newPass;
	private String newCode;
	
	public String getMD5(String pass){
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(pass.getBytes());
			byte byteData[] = md.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			passMD5 = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return passMD5;
	}
	
	/// 새로운 패스워드 임의 생성 코드.
	
	public String getNewPass(){
		ran = new Random();
		StringBuffer sb = new StringBuffer();
		for(int i =0; i<7; i++){
			char s = (char)(ran.nextInt(25)+97);
			sb.append(s);
		}
		newPass =sb.toString();
		return newPass;
	}
	
	// 인증번호 생성 코드
	
	public String getNewCode(){
		ran = new Random();
		StringBuffer sb = new StringBuffer();
		
		for(int i =0; i<4; i++){
			char s = (char)(ran.nextInt(25)+97);
			sb.append(s);
		}
		newCode = sb.toString();
		return newCode;
	}
}

