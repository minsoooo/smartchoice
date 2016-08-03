package com.smartchoice.app.domain;

import java.util.ArrayList;
import java.util.List;

public class cardResultDto {
	private String cardName;
	private String cardImg;
	private String cardCode;
	private String cardAnnualfee; //연 회비
	
	private List smallName = new ArrayList();
	private List smallNum = new ArrayList();
	private List smallMoney = new ArrayList();
	private List planMoney = new ArrayList();  
	private List etcName = new ArrayList();  
	private List etcContent = new ArrayList();  
	private int totalMoney;
	private int monthMoney;
	private int usemonthMoney; //월 사용액
	private int useetcMoney; //월 기타 사용액
	
	
	
	public int getUsemonthMoney() {
		return usemonthMoney;
	}
	public void setUsemonthMoney(int usemonthMoney) {
		this.usemonthMoney = usemonthMoney;
	}
	public int getUseetcMoney() {
		return useetcMoney;
	}
	public void setUseetcMoney(int useetcMoney) {
		this.useetcMoney = useetcMoney;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	
	public String getCardAnnualfee() {
		return cardAnnualfee;
	}
	public int getCardAnnual12fee() {
		return Integer.parseInt(cardAnnualfee)/12;
	}
	public void setCardAnnualfee(String cardAnnualfee) {
		this.cardAnnualfee = cardAnnualfee;
	}
	
	public String getCardImg() {
		return cardImg;
	}
	public void setCardImg(String cardImg) {
		this.cardImg = cardImg;
	}
	public String getCardCode() {
		return cardCode;
	}
	public void setCardCode(String cardCode) {
		this.cardCode = cardCode;
	}
	
	public List getEtcName() {
		return etcName;
	}
	public void setEtcName(String etcName) {
		this.etcName.add(etcName);
	}

	public List getEtcContent() {
		return etcContent;
	}
	public void setEtcContent(String etcContent) {
		this.etcContent.add(etcContent);
	}
	
	public List getSmallNum() {
		return smallNum;
	}
	public void setSmallNum(int smallNum) {
		this.smallNum.add(smallNum);
	}
	
	public List getSmallName() {
		return smallName;
	}
	public void setSmallName(String smallName) {
		this.smallName.add(smallName);
	}
	
	public List getSmallMoney() {
		return smallMoney;
	}
	public void setSmallMoney(int smallMoney) {
		this.smallMoney.add(smallMoney);
	}
	//
	public List getPlanMoney() {
		return planMoney;
	}
	public void setPlanMoney(int planMoney) {
		this.planMoney.add(planMoney);
	}
	//
	public int getTotalMoney() {
		int saveMoney = 0;
		for(int i=0 ; i<smallMoney.size() ; i++){
			saveMoney += (Integer) smallMoney.get(i);
		}
		totalMoney=saveMoney;
		return totalMoney;
	}
	public void setTotalMoney(int totalMoney) {
		this.totalMoney = totalMoney;
	}
	
	public int getMonthMoney(){
		this.monthMoney = totalMoney-(Integer.parseInt(cardAnnualfee)/12);
		if(this.monthMoney < 0)
			this.monthMoney = 0;
		return monthMoney;
	}
}
