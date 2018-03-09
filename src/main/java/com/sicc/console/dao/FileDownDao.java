package com.sicc.console.dao;

import java.util.List;

public interface FileDownDao {

	public List<String> selTenantIdByAllData(String tenantId);
	
	public List<String> selTenantList();
	
}
