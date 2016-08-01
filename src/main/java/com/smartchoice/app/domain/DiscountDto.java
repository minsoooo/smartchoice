package com.smartchoice.app.domain;


public class DiscountDto {
	private int dc_num;
	private int dc_min;
	private int dc_max;
	private int dc_value;
	private int dc_classify;
	private String dc_etc;
	private int dc_cardcode;
	private int dc_smallnum;
	private int card_typeflag; //카드 구분
	private int dc_discountMoney;//할인된 금액
	private String small_name; // 소분류 이름
	
	public String getSmall_name() {
		return small_name;
	}
	public void setSmall_name(String small_name) {
		this.small_name = small_name;
	}
	public int getDc_num() {
		return dc_num;
	}
	public void setDc_num(int dc_num) {
		this.dc_num = dc_num;
	}
	public int getDc_min() {
		return dc_min;
	}
	public void setDc_min(int dc_min) {
		this.dc_min = dc_min;
	}
	public int getDc_max() {
		return dc_max;
	}
	public void setDc_max(int dc_max) {
		this.dc_max = dc_max;
	}
	public int getDc_value() {
		return dc_value;
	}
	public void setDc_value(int dc_value) {
		this.dc_value = dc_value;
	}
	public int getDc_classify() {
		return dc_classify;
	}
	public void setDc_classify(int dc_classify) {
		this.dc_classify = dc_classify;
	}
	public String getDc_etc() {
		return dc_etc;
	}
	public void setDc_etc(String dc_etc) {
		this.dc_etc = dc_etc;
	}
	public int getDc_cardcode() {
		return dc_cardcode;
	}
	public void setDc_cardcode(int dc_cardcode) {
		this.dc_cardcode = dc_cardcode;
	}
	public int getDc_smallnum() {
		return dc_smallnum;
	}
	public void setDc_smallnum(int dc_smallnum) {
		this.dc_smallnum = dc_smallnum;
	}
	public int getDc_discountMoney() {
		return dc_discountMoney;
	}
	public void setDc_discountMoney(int dc_discountMoney) {
		this.dc_discountMoney = dc_discountMoney;
	}
	public int getCard_typeflag() {
		return card_typeflag;
	}
	public void setCard_typeflag(int card_typeflag) {
		this.card_typeflag = card_typeflag;
	}
	
	
	
}