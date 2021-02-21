package org.kosta.banchan.model.vo;

import java.util.ArrayList;

public class FoodSellVO extends FoodVO {
	private ArrayList<QuestionVO> questionList;
	private String foodSellNo;
	private String trDate;
	private String closeDate;
	private String loc;
	private int price;
	private int preQuantity;
	private String sellPostdate;
	private String unit;
	private String sellDetail;

	public FoodSellVO() {
		super();
	}

	public ArrayList<QuestionVO> getQuestionList() {
		return questionList;
	}

	public void setQuestionList(ArrayList<QuestionVO> questionList) {
		this.questionList = questionList;
	}

	public String getFoodSellNo() {
		return foodSellNo;
	}

	public void setFoodSellNo(String foodSellNo) {
		this.foodSellNo = foodSellNo;
	}

	public String getTrDate() {
		return trDate;
	}

	public void setTrDate(String trDate) {
		this.trDate = trDate;
	}

	public String getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(String closeDate) {
		this.closeDate = closeDate;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getPreQuantity() {
		return preQuantity;
	}

	public void setPreQuantity(int preQuantity) {
		this.preQuantity = preQuantity;
	}

	public String getSellPostdate() {
		return sellPostdate;
	}

	public void setSellPostdate(String sellPostdate) {
		this.sellPostdate = sellPostdate;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getSellDetail() {
		return sellDetail;
	}

	public void setSellDetail(String sellDetail) {
		this.sellDetail = sellDetail;
	}

	@Override
	public String toString() {
		return "FoodSellVO [questionList=" + questionList + ", foodSellNo=" + foodSellNo + ", trDate=" + trDate
				+ ", closeDate=" + closeDate + ", loc=" + loc + ", price=" + price + ", preQuantity=" + preQuantity
				+ ", sellPostdate=" + sellPostdate + ", unit=" + unit + ", sellDetail=" + sellDetail + ", toString()="
				+ super.toString() + ", getMemId()=" + getMemId() + ", getUploadImage()=" + getUploadImage()
				+ ", getReviewList()=" + getReviewList() + ", getFoodNo()=" + getFoodNo() + ", getFoodName()="
				+ getFoodName() + ", getFoodDe()=" + getFoodDe() + ", getFoodScore()=" + getFoodScore()
				+ ", getFoodMainImg()=" + getFoodMainImg() + ", getFoodPostdate()=" + getFoodPostdate()
				+ ", getCategoryNo()=" + getCategoryNo() + ", getSellerVO()=" + getSellerVO() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + "]";
	}
	
}