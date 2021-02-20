
package org.kosta.banchan.model.vo;

public class TradeVO {

	private String trNo;
	private int trQuantity;//
	private String trReqDate; // 거래 신청한 날짜
	private String trFinDate; // 거래완료 버튼 누른날짜
	private String memId;// 주문자아이디
	private String trStatusNo;
	private String trStatus;
	private FoodSellVO foodSellVO;// foodSellNo

	public TradeVO() {
		super();
	}

	@Override
	public String toString() {
		return "TradeVO [trNo=" + trNo + ", trQuantity=" + trQuantity + ", trReqDate=" + trReqDate + ", trFinDate="
				+ trFinDate + ", memId=" + memId + ", trStatusNo=" + trStatusNo + ", trStatus=" + trStatus
				+ ", foodSellVO=" + foodSellVO + "]";
	}

	public String getTrNo() {
		return trNo;
	}

	public void setTrNo(String trNo) {
		this.trNo = trNo;
	}

	public int getTrQuantity() {
		return trQuantity;
	}

	public void setTrQuantity(int trQuantity) {
		this.trQuantity = trQuantity;
	}

	public String getTrReqDate() {
		return trReqDate;
	}

	public void setTrReqDate(String trReqDate) {
		this.trReqDate = trReqDate;
	}

	public String getTrFinDate() {
		return trFinDate;
	}

	public void setTrFinDate(String trFinDate) {
		this.trFinDate = trFinDate;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getTrStatusNo() {
		return trStatusNo;
	}

	public void setTrStatusNo(String trStatusNo) {
		this.trStatusNo = trStatusNo;
	}

	public FoodSellVO getFoodSellVO() {
		return foodSellVO;
	}

	public void setFoodSellVO(FoodSellVO foodSellVO) {
		this.foodSellVO = foodSellVO;
	}

	public String getTrStatus() {
		return trStatus;
	}

	public void setTrStatus(String trStatus) {
		this.trStatus = trStatus;
	}
}