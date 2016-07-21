package com.smartchoice.app.domain;

public class MemberDto {

	private int mem_num;
	private String mem_id;
	private String mem_level;
	private String mem_email;
	private String mem_pw;
	private String mem_fav1;
	private String mem_fav2;
	private String mem_fav3;
	private String mem_cardcode;
	
	
	public String getMem_fav1() {
		return mem_fav1;
	}

	public void setMem_fav1(String mem_fav1) {
		this.mem_fav1 = mem_fav1;
	}

	public String getMem_fav2() {
		return mem_fav2;
	}

	public void setMem_fav2(String mem_fav2) {
		this.mem_fav2 = mem_fav2;
	}

	public String getMem_fav3() {
		return mem_fav3;
	}

	public void setMem_fav3(String mem_fav3) {
		this.mem_fav3 = mem_fav3;
	}

	public String getMem_cardcode() {
		return mem_cardcode;
	}

	public void setMem_cardcode(String mem_cardcode) {
		this.mem_cardcode = mem_cardcode;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getMem_level() {
		return mem_level;
	}

	public void setMem_level(String mem_level) {
		this.mem_level = mem_level;
	}

	public String getMem_email() {
		return mem_email;
	}

	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	
	
	@Override
	public String toString() {
		return "MemberDto getMem_num():" +getMem_num()+" getMem_level() : "
				+getMem_level() +" getMem_email : "+getMem_email()+
				" getMem_pw : " +getMem_pw() + " getMem_id : "+getMem_id() +
				 " getMem_fav1 : "+getMem_fav1()+" getMem_fav2 : "+
				getMem_fav2()+" getMem_fav3 : " +getMem_fav3() +" getMem_cardcode"
				+getMem_cardcode();
	}

}
