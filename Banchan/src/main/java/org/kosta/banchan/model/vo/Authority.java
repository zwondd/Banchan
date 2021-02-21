package org.kosta.banchan.model.vo;

public class Authority {

	private String memId;
	private String authNo;
	private String authName;

	public Authority() {
		super();
	}

	public Authority(String memId, String authNo) {
		super();
		this.memId = memId;
		this.authNo = authNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getAuthNo() {
		return authNo;
	}

	public void setAuthNo(String authNo) {
		this.authNo = authNo;
	}

	public Authority(String memId, String authNo, String authName) {
		super();
		this.memId = memId;
		this.authNo = authNo;
		this.authName = authName;
	}

	public String getAuthName() {
		return authName;
	}

	public void setAuthName(String authName) {
		this.authName = authName;
	}

	@Override
	public String toString() {
		return "Authority [memId=" + memId + ", authNo=" + authNo + ", authName=" + authName + "]";
	}

}