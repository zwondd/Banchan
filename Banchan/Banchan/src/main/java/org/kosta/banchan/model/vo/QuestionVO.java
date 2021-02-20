package org.kosta.banchan.model.vo;

import java.util.ArrayList;

public class QuestionVO {

	private String questNo;
	private String questContent;
	private String questPostdate;
	private String foodSellNo;
	private String memId;
	private ArrayList<AnswerVO> answerList;

	public QuestionVO() {
		super();
	}

	@Override
	public String toString() {
		return "QuestionVO [questNo=" + questNo + ", questContent=" + questContent + ", questPostdate=" + questPostdate
				+ ", foodSellNo=" + foodSellNo + ", memId=" + memId + ", answerList=" + answerList + "]";
	}

	public String getQuestNo() {
		return questNo;
	}

	public void setQuestNo(String questNo) {
		this.questNo = questNo;
	}

	public String getQuestContent() {
		return questContent;
	}

	public void setQuestContent(String questContent) {
		this.questContent = questContent;
	}

	public String getQuestPostdate() {
		return questPostdate;
	}

	public void setQuestPostdate(String questPostdate) {
		this.questPostdate = questPostdate;
	}

	public String getFoodSellNo() {
		return foodSellNo;
	}

	public void setFoodSellNo(String foodSellNo) {
		this.foodSellNo = foodSellNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public ArrayList<AnswerVO> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(ArrayList<AnswerVO> answerList) {
		this.answerList = answerList;
	}

}