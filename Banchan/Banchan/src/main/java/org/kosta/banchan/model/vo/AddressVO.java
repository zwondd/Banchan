package org.kosta.banchan.model.vo;

public class AddressVO {

	private String addressNo;
	private String addressAPI;
	private double latitude;
	private double longitude;

	public AddressVO() {
		super();
	}

	@Override
	public String toString() {
		return "AddressVO [addressNo=" + addressNo + ", addressAPI=" + addressAPI + ", latitude=" + latitude
				+ ", longitude=" + longitude + "]";
	}

	public String getAddressNo() {
		return addressNo;
	}

	public void setAddressNo(String addressNo) {
		this.addressNo = addressNo;
	}

	public String getAddressAPI() {
		return addressAPI;
	}

	public void setAddressAPI(String addressAPI) {
		this.addressAPI = addressAPI;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

}