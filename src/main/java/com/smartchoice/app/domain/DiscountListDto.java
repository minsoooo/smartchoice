package com.smartchoice.app.domain;

import java.util.List;

public class DiscountListDto {
	
	private String dc_cardcode;
	private int dcL_discountMoney; //할인된 금액
	private List dcL_discountMoneyList;
	private int dcL_totaldiscountMoney; //총 할인금액
	
	public String getDc_cardcode() {
		return dc_cardcode;
	}
	public void setDc_cardcode(String dc_cardcode) {
		this.dc_cardcode = dc_cardcode;
	}
	public int getDcL_discountMoney() {
		return dcL_discountMoney;
	}
	public void setDcL_discountMoney(int dcL_discountMoney) {
		this.dcL_discountMoney = dcL_discountMoney;
	}
	public int getDcL_totaldiscountMoney() {
		return dcL_totaldiscountMoney;
	}
	public void setDcL_totaldiscountMoney(int dcL_totaldiscountMoney) {
		this.dcL_totaldiscountMoney = dcL_totaldiscountMoney;
		this.dcL_discountMoneyList.add(dcL_totaldiscountMoney);
	}
	
	
}
