package com.smartchoice.app.util;
/*
 * 	 작성자 : 박민수
 * 	 작성일 : 2016-07-16
 * 	 설명 : MD5알고리즘 패스워드생성/ 코드생성/ 새로운비밀번호 생성
 * 
 */
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class Cipher {
	private Random ran ;
	private String passMD5;
	private String newPass;
	private String newCode;
	
	// MD5 암호 얻기
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
	
	/// 새로운패스워드 얻기
	
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
	
	// 인증코드 얻기
	
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

