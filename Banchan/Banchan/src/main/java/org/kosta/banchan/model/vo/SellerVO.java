package org.kosta.banchan.model.vo;

import org.springframework.web.multipart.MultipartFile;

public class SellerVO extends MemberVO {

	private static final long serialVersionUID = 4427951495449264548L;

	private String sellerImg;
	private String sellerInfo;
	private float sellerScore;
	private MultipartFile uploadImage;

	public SellerVO() {
		super();
	}

	public SellerVO(String sellerImg, String sellerInfo) {
		super();
		this.sellerImg = sellerImg;
		this.sellerInfo = sellerInfo;
	}

	public String getSellerImg() {
		return sellerImg;
	}

	public void setSellerImg(String sellerImg) {
		this.sellerImg = sellerImg;
	}

	public String getSellerInfo() {
		return sellerInfo;
	}

	public void setSellerInfo(String sellerInfo) {
		this.sellerInfo = sellerInfo;
	}

	public float getSellerScore() {
		return sellerScore;
	}

	public void setSellerScore(float sellerScore) {
		this.sellerScore = sellerScore;
	}

	public MultipartFile getUploadImage() {
		return uploadImage;
	}

	public void setUploadImage(MultipartFile uploadImage) {
		this.uploadImage = uploadImage;
	}

	@Override
	public String toString() {
		return "SellerVO [sellerImg=" + sellerImg + ", sellerInfo=" + sellerInfo + ", sellerScore=" + sellerScore
				+ ", uploadImage=" + uploadImage + ", getSellerImg()=" + getSellerImg() + ", getSellerInfo()="
				+ getSellerInfo() + ", getSellerScore()=" + getSellerScore() + ", getUploadImage()=" + getUploadImage()
				+ ", toString()=" + super.toString() + ", getMemId()=" + getMemId() + ", getPw()=" + getPw()
				+ ", getMemName()=" + getMemName() + ", getBirth()=" + getBirth() + ", getTel()=" + getTel()
				+ ", getAddressDe()=" + getAddressDe() + ", getPwAnswer()=" + getPwAnswer() + ", getEnableNo()="
				+ getEnableNo() + ", getPwQnaNo()=" + getPwQnaNo() + ", getAddressVO()=" + getAddressVO()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + "]";
	}

}