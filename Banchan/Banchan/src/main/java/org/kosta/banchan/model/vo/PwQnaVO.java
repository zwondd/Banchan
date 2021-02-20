package org.kosta.banchan.model.vo;

public class PwQnaVO {
	private String pwQnaNo;
	private String pwQuest;

	public PwQnaVO() {
		super();
	}

	@Override
	public String toString() {
		return "PwQnaVO [pwQnaNo=" + pwQnaNo + ", pwQuest=" + pwQuest + "]";
	}

	public String getPwQnaNo() {
		return pwQnaNo;
	}

	public void setPwQnaNo(String pwQnaNo) {
		this.pwQnaNo = pwQnaNo;
	}

	public String getPwQuest() {
		return pwQuest;
	}

	public void setPwQuest(String pwQuest) {
		this.pwQuest = pwQuest;
	}

}
