package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.CodeModel;

public interface CodeDao {
	public List<CodeModel> selCode(String cdGroupId);
}

