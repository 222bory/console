package com.sicc.console.dao;

import java.util.List;
import java.util.Map;

import com.sicc.console.model.CodeModel;

public interface CodeDao {
	public List<CodeModel> selCode(String cdGroupId);
	
	 public String selCodeByCdId(String cdGroupId, String cdId) ;
}

