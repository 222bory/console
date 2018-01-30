package com.sicc.console.model;

import java.util.Date;

public class AdminModel {
	private String adminId;
	private String adminNm;
	private String adminPrivCd;
	private String emailAddr;
	private String password;
	private Date adDate;
	private Date udtDate;
	private String crtId;
	private String crtIp;
	private String udtId;
	private String udtIp;
	//페이징 처리
	private Integer page;
    private int rowPerPage;
    private int skipCount;
    private Integer totalCount; 
	
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	public int getSkipCount() {
		return skipCount;
	}
	public void setSkipCount(int skipCount) {
		this.skipCount = skipCount;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
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
	public String getCrtId() {
		return crtId;
	}
	public void setCrtId(String crtId) {
		this.crtId = crtId;
	}
	public String getCrtIp() {
		return crtIp;
	}
	public void setCrtIp(String crtIp) {
		this.crtIp = crtIp;
	}
	public String getUdtId() {
		return udtId;
	}
	public void setUdtId(String udtId) {
		this.udtId = udtId;
	}
	public String getUdtIp() {
		return udtIp;
	}
	public void setUdtIp(String udtIp) {
		this.udtIp = udtIp;
	}
	
	
}
