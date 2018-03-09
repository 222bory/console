package com.sicc.console.model;

import java.util.Date;

public class ContractExtModel extends ContractModel{
	//contract
	private String tenantId;
	private String custId;
	private String contNm;
	private String validStartDt;
	private String validEndDt;
	private String contStatCd;
	private String networkFgCd;
	private String passwordLodCd;
	private int passwordMinLen;
	private String passwordRnwlCyclCd;
	private String passwordUseLmtYn;
	private String passwordPoseYn;
	private String crtId;
	private String crtIp;
	private Date adDate;
	private String udtId;
	private String udtIp;
	private Date udtDate;
	//custmer
	private String custNm;
	private String repFaxNo;
	private String repTelNo;
	private String corpAdNo;
	private String mgrNm;
	private String mgrEmailAddr;
	private String mgrTelNo;
	//페이징 처리
	private Integer page;
    private int rowPerPage;
    private int skipCount;
    private Integer totalCount;
    //검색
    private String serachGroup;
    private String serachNm;
    
	public String getTenantId() {
		return tenantId;
	}
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getContNm() {
		return contNm;
	}
	public void setContNm(String contNm) {
		this.contNm = contNm;
	}
	public String getValidStartDt() {
		return validStartDt;
	}
	public void setValidStartDt(String validStartDt) {
		this.validStartDt = validStartDt;
	}
	public String getValidEndDt() {
		return validEndDt;
	}
	public void setValidEndDt(String validEndDt) {
		this.validEndDt = validEndDt;
	}
	public String getContStatCd() {
		return contStatCd;
	}
	public void setContStatCd(String contStatCd) {
		this.contStatCd = contStatCd;
	}
	public String getNetworkFgCd() {
		return networkFgCd;
	}
	public void setNetworkFgCd(String networkFgCd) {
		this.networkFgCd = networkFgCd;
	}
	public String getPasswordLodCd() {
		return passwordLodCd;
	}
	public void setPasswordLodCd(String passwordLodCd) {
		this.passwordLodCd = passwordLodCd;
	}
	public int getPasswordMinLen() {
		return passwordMinLen;
	}
	public void setPasswordMinLen(int passwordMinLen) {
		this.passwordMinLen = passwordMinLen;
	}
	public String getPasswordRnwlCyclCd() {
		return passwordRnwlCyclCd;
	}
	public void setPasswordRnwlCyclCd(String passwordRnwlCyclCd) {
		this.passwordRnwlCyclCd = passwordRnwlCyclCd;
	}
	public String getPasswordUseLmtYn() {
		return passwordUseLmtYn;
	}
	public void setPasswordUseLmtYn(String passwordUseLmtYn) {
		this.passwordUseLmtYn = passwordUseLmtYn;
	}
	public String getPasswordPoseYn() {
		return passwordPoseYn;
	}
	public void setPasswordPoseYn(String passwordPoseYn) {
		this.passwordPoseYn = passwordPoseYn;
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
	public Date getAdDate() {
		return adDate;
	}
	public void setAdDate(Date adDate) {
		this.adDate = adDate;
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
	public Date getUdtDate() {
		return udtDate;
	}
	public void setUdtDate(Date udtDate) {
		this.udtDate = udtDate;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getRepFaxNo() {
		return repFaxNo;
	}
	public void setRepFaxNo(String repFaxNo) {
		this.repFaxNo = repFaxNo;
	}
	public String getRepTelNo() {
		return repTelNo;
	}
	public void setRepTelNo(String repTelNo) {
		this.repTelNo = repTelNo;
	}
	public String getCorpAdNo() {
		return corpAdNo;
	}
	public void setCorpAdNo(String corpAdNo) {
		this.corpAdNo = corpAdNo;
	}
	public String getMgrNm() {
		return mgrNm;
	}
	public void setMgrNm(String mgrNm) {
		this.mgrNm = mgrNm;
	}
	public String getMgrEmailAddr() {
		return mgrEmailAddr;
	}
	public void setMgrEmailAddr(String mgrEmailAddr) {
		this.mgrEmailAddr = mgrEmailAddr;
	}
	public String getMgrTelNo() {
		return mgrTelNo;
	}
	public void setMgrTelNo(String mgrTelNo) {
		this.mgrTelNo = mgrTelNo;
	}
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
	public String getSerachGroup() {
		return serachGroup;
	}
	public void setSerachGroup(String serachGroup) {
		this.serachGroup = serachGroup;
	}
	public String getSerachNm() {
		return serachNm;
	}
	public void setSerachNm(String serachNm) {
		this.serachNm = serachNm;
	}
	
}
