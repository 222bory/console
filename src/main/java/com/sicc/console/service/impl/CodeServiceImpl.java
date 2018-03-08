package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.CodeDao;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.MonitorModel;
import com.sicc.console.service.CodeService;

@Service
public class CodeServiceImpl implements CodeService {
	@Autowired
	private CodeDao codeDao;
	
	@Override
	public List<CodeModel> selListCode(CodeModel codeModel){
		return codeDao.selListCode(codeModel); 
	};
	
	@Override
	public List<CodeModel> selCode(CodeModel codeModel){
		return codeDao.selCode(codeModel); 
	};
	
	@Override
	public void insCodeMaster(CodeModel codeModel) {
		codeDao.insCodeMaster(codeModel);
	}
	
	@Override
	public void insCodeDetail(CodeModel codeModel) {
		codeDao.insCodeDetail(codeModel);
	}
	
	@Override
	public void delCodeMaster(CodeModel codeModel) {
		codeDao.delCodeMaster(codeModel);
	}
	
	@Override
	public void delCodeDetail(CodeModel codeModel) {
		codeDao.delCodeDetail(codeModel);
	}
	
}
 