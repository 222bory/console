package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.CodeModel;

public interface UtilDao {
	public List<CodeModel> selCode(String cdGroupId);
	
	public int selTenantIdSeq();
}

