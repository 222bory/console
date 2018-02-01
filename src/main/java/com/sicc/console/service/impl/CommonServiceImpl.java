package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.CodeDao;
import com.sicc.console.model.CodeModel;
import com.sicc.console.service.CommonService;

@Service
public class CommonServiceImpl implements CommonService{ 
	
	@Autowired
	private CodeDao codeDao;

	@Override
	public List<CodeModel> selCode(String cdGroupId) {
		return codeDao.selCode(cdGroupId);
	}
	
}
