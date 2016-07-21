

/*
 * 	2016.07.29
 * 	CardDto 작성
 */
package com.smartchoice.app.domain;

public class CardDto {
	private String comp_name;//회사명
	private int comp_num;//회사넘버
	private String card_name;//카드명
	private int card_num;//카드넘버
	private int card_annualfee;//연회비
	private int card_lastrecord;//전월실적
	private int card_typeflag;//카드종류(0=신용, 1=체크)
	private int card_useflag;//카드활성유무(0=활성, 1=비활성)
	private String card_code;
	private String card_img;
	
	public String getCard_code() {
		return card_code;
	}
	public void setCard_code(String card_code) {
		this.card_code = card_code;
	}
	public String getCard_img() {
		return card_img;
	}
	public void setCard_img(String card_img) {
		this.card_img = card_img;
	}
	public String getComp_name() {
		return comp_name;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	public int getComp_num() {
		return comp_num;
	}
	public void setComp_num(int comp_num) {
		this.comp_num = comp_num;
	}
	public String getCard_name() {
		return card_name;
	}
	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}
	public int getCard_num() {
		return card_num;
	}
	public void setCard_num(int card_num) {
		this.card_num = card_num;
	}
	public int getCard_annualfee() {
		return card_annualfee;
	}
	public void setCard_annualfee(int card_annualfee) {
		this.card_annualfee = card_annualfee;
	}
	public int getCard_lastrecord() {
		return card_lastrecord;
	}
	public void setCard_lastrecord(int card_lastrecord) {
		this.card_lastrecord = card_lastrecord;
	}
	public int getCard_typeflag() {
		return card_typeflag;
	}
	public void setCard_typeflag(int card_typeflag) {
		this.card_typeflag = card_typeflag;
	}
	public int getCard_useflag() {
		return card_useflag;
	}
	public void setCard_useflag(int card_useflag) {
		this.card_useflag = card_useflag;
	}
	
	
	@Override
	public String toString() {
		return "CardDto [comp_name=" + comp_name + ", comp_num=" + comp_num + ", card_name=" + card_name + ", card_num="
				+ card_num + ", card_annualfee=" + card_annualfee + ", card_lastrecord=" + card_lastrecord
				+ ", card_typeflag=" + card_typeflag + ", card_useflag=" + card_useflag + "]";

	}
	
	
}
