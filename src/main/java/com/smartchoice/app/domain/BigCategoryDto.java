/*
 * 	카드추천 BigclassDto
		
	작성일 : 2016-07-19
	수정일 : 2016-07-19
	작성자 : 김상덕
 */
package com.smartchoice.app.domain;

public class BigCategoryDto {
	
	private int big_num;
	private String big_name;
	
	public int getBig_num() {
		return big_num;
	}
	public void setBig_num(int big_num) {
		this.big_num = big_num;
	}
	public String getBig_name() {
		return big_name;
	}
	public void setBig_name(String big_name) {
		this.big_name = big_name;
	}
}
