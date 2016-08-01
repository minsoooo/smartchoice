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
	private String fav1_name;
	private String fav2_name;
	private String fav3_name;
	private String mem_cardcode;
	private String card_name;
	private String mem_regdate;
	private int comp_num;
	private String comp_name;
	private String mem_birthdate;
	

	public String getFav1_name() {
		return fav1_name;
	}
	
	public void setFav1_name(String fav1_name) {
		this.fav1_name = fav1_name;
	}
	
	public String getFav2_name() {
		return fav2_name;
	}
	
	public void setFav2_name(String fav2_name) {
		this.fav2_name = fav2_name;
	}
	
	public String getFav3_name() {
		return fav3_name;
	}
	
	public void setFav3_name(String fav3_name) {
		this.fav3_name = fav3_name;
	}
	
	public String getComp_name() {
		return comp_name;
	}
	
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	
	
	public String getMem_birthdate() {
		return mem_birthdate;
	}

	public void setMem_birthdate(String mem_birthdate) {
		this.mem_birthdate = mem_birthdate;
	}

	public int getComp_num() {
		return comp_num;
	}

	public void setComp_num(int comp_num) {
		this.comp_num = comp_num;
	}

	public String getMem_regdate() {
		return mem_regdate;
	}

	public void setMem_regdate(String mem_regdate) {
		this.mem_regdate = mem_regdate;
	}

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
				getMem_fav2()+" getMem_fav3 : " +getMem_fav3() +" getMem_cardcode : "
				+getMem_cardcode() +" getCard_name : "+getCard_name()+" getComp_num : " +getComp_num() + " getMem_birthdate : "
				+getMem_birthdate() + "getFav1_name : "+getFav1_name()+" getFav2_name : "+getFav2_name()+ " getFav3_name : "
				+getFav3_name() + " getComp_name : " +getComp_name() ;
	}

	public String getCard_name() {
		return card_name;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

}
