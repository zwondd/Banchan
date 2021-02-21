package org.kosta.banchan.model.vo;

import java.io.Serializable;

public class MemberVO implements Serializable {

	private static final long serialVersionUID = 2707970356262471354L;
	private String memId;
	private String pw;
	private String memName;
	private String birth;
	private String tel;
	private String addressDe;
	private String pwAnswer;
	private String enableNo;
	private String pwQnaNo;


	private AddressVO addressVO;

	public MemberVO() {
		super();
	}

	public MemberVO(String memId, String memName, String birth, String tel, String addressDe, String pwAnswer,
			String enableNo, String pwQnaNo) {
		super();
		this.memId = memId;
		this.memName = memName;
		this.birth = birth;
		this.tel = tel;
		this.addressDe = addressDe;
		this.pwAnswer = pwAnswer;
		this.enableNo = enableNo;
		this.pwQnaNo = pwQnaNo;
	}
	
	public MemberVO(String memId, String memName) {
		super();
		this.memId = memId;
		this.memName = memName;
	}
	/**
	 * 비밀번호 찾기 질문답변에 사용
	 * @param memId
	 * @param memName
	 * @param pwQnaNo
	 * @param pwAnswer
	 */
	public MemberVO(String memId, String memName, String pwQnaNo, String pwAnswer) {
		super();
		this.memId = memId;
		this.memName = memName;
		this.pwQnaNo = pwQnaNo;
		this.pwAnswer = pwAnswer;
	}
	/**
	 * 비밀번호 찾기 회원확인에 사용
	 * @param memId
	 * @param memName
	 * @param tel
	 */
	public MemberVO(String memId, String memName, String tel) {
		super();
		this.memId = memId;
		this.memName = memName;
		this.tel = tel;
	}

	
	

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", pw=" + pw + ", memName=" + memName + ", birth=" + birth + ", tel=" + tel
				+ ", addressDe=" + addressDe + ", pwAnswer=" + pwAnswer + ", enableNo=" + enableNo + ", pwQnaNo="
				+ pwQnaNo + ", addressVO=" + addressVO + "]";
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddressDe() {
		return addressDe;
	}

	public void setAddressDe(String addressDe) {
		this.addressDe = addressDe;
	}

	public String getPwAnswer() {
		return pwAnswer;
	}

	public void setPwAnswer(String pwAnswer) {
		this.pwAnswer = pwAnswer;
	}

	public String getEnableNo() {
		return enableNo;
	}

	public void setEnableNo(String enableNo) {
		this.enableNo = enableNo;
	}

	public String getPwQnaNo() {
		return pwQnaNo;
	}

	public void setPwQnaNo(String pwQnaNo) {
		this.pwQnaNo = pwQnaNo;
	}

	public AddressVO getAddressVO() {
		return addressVO;
	}

	public void setAddressVO(AddressVO addressVO) {
		this.addressVO = addressVO;
	}


}