package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.CodeModel;

public interface CodeDao {
	public List<CodeModel> selCode(String cdGroupId);
	
	public String selCodeByCdId(String cdGroupId, String cdId) ;
	
	public List<CodeModel> selListCode(CodeModel codeModel);
	
	public List<CodeModel> selCode(CodeModel codeModel);
	
	public void insCodeMaster(CodeModel codeModel);
		
	public void insCodeDetail(CodeModel codeModel);
	
	public void delCodeMaster(CodeModel codeModel);
	
	public void delCodeDetail(CodeModel codeModel);
}

