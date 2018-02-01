package com.sicc.console.model;

import java.util.Date;

public class ServiceDetailModel {
	
	private String tenantId;
	private String cpCd;
	private String serviceCd;
	private String systemCd;
	private String serviceStartDt;
	private String serviceEndDt;
	private String serviceUrlAddr;
	private String crtId;
	private String crtIp;
	private Date adDate;
	private String udtId;
	private String udtIp;
	private Date udtDate;
	
	public String getTenantId() {
		return tenantId;
	}
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}
	public String getCpCd() {
		return cpCd;
	}
	public void setCpCd(String cpCd) {
		this.cpCd = cpCd;
	}
	public String getServiceCd() {
		return serviceCd;
	}
	public void setServiceCd(String serviceCd) {
		this.serviceCd = serviceCd;
	}
	public String getSystemCd() {
		return systemCd;
	}
	public void setSystemCd(String systemCd) {
		this.systemCd = systemCd;
	}
	public String getServiceStartDt() {
		return serviceStartDt;
	}
	public void setServiceStartDt(String serviceStartDt) {
		this.serviceStartDt = serviceStartDt;
	}
	public String getServiceEndDt() {
		return serviceEndDt;
	}
	public void setServiceEndDt(String serviceEndDt) {
		this.serviceEndDt = serviceEndDt;
	}
	public String getServiceUrlAddr() {
		return serviceUrlAddr;
	}
	public void setServiceUrlAddr(String serviceUrlAddr) {
		this.serviceUrlAddr = serviceUrlAddr;
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
	
}
