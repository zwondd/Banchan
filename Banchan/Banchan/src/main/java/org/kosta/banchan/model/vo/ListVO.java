package org.kosta.banchan.model.vo;

import java.util.List;

public class ListVO<T> {

	private List<T> list;
	private PagingBean pb;

	public ListVO() {
		super();
	}

	@Override
	public String toString() {
		return "ListVO [list=" + list + ", pb=" + pb + ", getList()=" + getList() + ", getPb()=" + getPb() + "]";
	}

	public ListVO(List<T> list, PagingBean pb) {
		super();
		this.list = list;
		this.pb = pb;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public PagingBean getPb() {
		return pb;
	}

	public void setPb(PagingBean pb) {
		this.pb = pb;
	}

}