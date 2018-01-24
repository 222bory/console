package com.sicc.admin.demo.model;

import java.util.Date;
import java.util.List;

public class Member {
	
	private String adminId;
	private String adminNm;
	private String adminPrivCd;
	private String emailAddr;
	private String password;
	private Date adDate;
	private Date udtDate;
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminNm() {
		return adminNm;
	}
	public void setAdminNm(String adminNm) {
		this.adminNm = adminNm;
	}
	public String getAdminPrivCd() {
		return adminPrivCd;
	}
	public void setAdminPrivCd(String adminPrivCd) {
		this.adminPrivCd = adminPrivCd;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getAdDate() {
		return adDate;
	}
	public void setAdDate(Date adDate) {
		this.adDate = adDate;
	}
	public Date getUdtDate() {
		return udtDate;
	}
	public void setUdtDate(Date udtDate) {
		this.udtDate = udtDate;
	}
	
	
}