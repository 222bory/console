package com.sicc.console.enums;

public enum AdminEnums {
	
	CONADMINM ("CONADMINM", "com.sicc.admin.dao.AdminDao.insertAdminUserH");
	
	private String code;
	private String value;
	
	private AdminEnums (String code, String value) {
		this.code = code;
		this.value = value;
	}

	public String getCode() {
		return code;
	}

	public String getValue() {
		return value;
	}
	
	
}
