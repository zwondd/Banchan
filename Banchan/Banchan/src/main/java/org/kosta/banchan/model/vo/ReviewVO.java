package org.kosta.banchan.model.vo;

public class ReviewVO {

	private String revNo;
	private int score;
	private String revContent;
	private String revPostdate;
	private String foodNo;
	private String memId; // +작성자 아이디(누가 작성했는지 식별)

	public ReviewVO() {
		super();
	}

	public String getRevNo() {
		return revNo;
	}

	public void setRevNo(String revNo) {
		this.revNo = revNo;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getRevContent() {
		return revContent;
	}

	public void setRevContent(String revContent) {
		this.revContent = revContent;
	}

	public String getRevPostdate() {
		return revPostdate;
	}

	public void setRevPostdate(String revPostdate) {
		this.revPostdate = revPostdate;
	}

	public String getFoodNo() {
		return foodNo;
	}

	public void setFoodNo(String foodNo) {
		this.foodNo = foodNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	@Override
	public String toString() {
		return "ReviewVO [revNo=" + revNo + ", score=" + score + ", revContent=" + revContent + ", revPostdate="
				+ revPostdate + ", foodNo=" + foodNo + ", memId=" + memId + "]";
	}

}