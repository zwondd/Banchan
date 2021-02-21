package org.kosta.banchan.model.vo;

public class ReportVO {
	private String keyword;
	private int hit;
	private int rk;
	public ReportVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReportVO(String keyword, int hit, int rk) {
		super();
		this.keyword = keyword;
		this.hit = hit;
		this.rk = rk;
	}
	public ReportVO(String keyword, int hit) {
		super();
		this.keyword = keyword;
		this.hit = hit;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int gethit() {
		return hit;
	}
	public void sethit(int hit) {
		this.hit = hit;
	}
	public int getRk() {
		return rk;
	}
	public void setRk(int rk) {
		this.rk = rk;
	}
	@Override
	public String toString() {
		return "ReportVO [keyword=" + keyword + ", hit=" + hit + ", rk=" + rk + "]";
	}
	
	
}
