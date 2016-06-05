package com.footmark.tools;

public class ResultObject {
	
	private String status;
	private Object result;
	
	
	public ResultObject() {
		super();
	}
	public ResultObject(String status, Object result) {
		super();
		this.status = status;
		this.result = result;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Object getResult() {
		return result;
	}
	public void setResult(Object result) {
		this.result = result;
	}
	
	

}
