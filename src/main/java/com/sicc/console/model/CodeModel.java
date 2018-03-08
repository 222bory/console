package com.sicc.console.model;

import java.util.Date;

public class CodeModel {
	
	private String cdGroupId;
	private String cdGroupNm;
	private String cdId;
	private String cdNm;
	private String sortOrd;
	private String useYn;
	private String crtId;
	private String crtIp;
	private Date adDate;
	private String udtId;
	private String udtIp;
	private Date udtDate;
	//페이징 처리
	private Integer page;
    private int rowPerPage;
    private int skipCount;
    private Integer totalCount;
    //검색
    private String serachGroup;
    private String serachNm;
	    
	public String getCdGroupId() {
		return cdGroupId;
	}
	public void setCdGroupId(String cdGroupId) {
		this.cdGroupId = cdGroupId;
	}
	public String getCdGroupNm() {
		return cdGroupNm;
	}
	public void setCdGroupNm(String cdGroupNm) {
		this.cdGroupNm = cdGroupNm;
	}
	public String getCdId() {
		return cdId;
	}
	public void setCdId(String cdId) {
		this.cdId = cdId;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
	public String getSortOrd() {
		return sortOrd;
	}
	public void setSortOrd(String sortOrd) {
		this.sortOrd = sortOrd;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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