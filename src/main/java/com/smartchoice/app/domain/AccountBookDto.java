package com.smartchoice.app.domain;

public class AccountBookDto {
	private int abook_num;
	private int abook_money;
	private int abook_bignum;
	private int abook_smallnum;
	private int abook_reginum;
	private int comp_num;
	private String comp_name;
	private String regi_month;
	

	public String getRegi_month() {
		return regi_month;
	}

	public void setRegi_month(String regi_month) {
		this.regi_month = regi_month;
	}

	public int getComp_num() {
		return comp_num;
	}

	public void setComp_num(int comp_num) {
		this.comp_num = comp_num;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public int getAbook_num() {
		return abook_num;
	}

	public void setAbook_num(int abook_num) {
		this.abook_num = abook_num;
	}

	public int getAbook_money() {
		return abook_money;
	}

	public void setAbook_money(int abook_money) {
		this.abook_money = abook_money;
	}

	public int getAbook_bignum() {
		return abook_bignum;
	}

	public void setAbook_bignum(int abook_bignum) {
		this.abook_bignum = abook_bignum;
	}

	public int getAbook_smallnum() {
		return abook_smallnum;
	}

	public void setAbook_smallnum(int abook_smallnum) {
		this.abook_smallnum = abook_smallnum;
	}

	public int getAbook_reginum() {
		return abook_reginum;
	}

	public void setAbook_reginum(int abook_reginum) {
		this.abook_reginum = abook_reginum;
	}

}
