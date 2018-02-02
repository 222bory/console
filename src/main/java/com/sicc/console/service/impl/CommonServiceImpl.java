package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.common.CommonUtil;
import com.sicc.console.dao.CodeDao;
import com.sicc.console.dao.UtilDao;
import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.CodeModel;
import com.sicc.console.service.CommonService;

@Service
public class CommonServiceImpl implements CommonService{ 
	
	@Autowired
	private CodeDao codeDao;
	
	@Autowired
	private UtilDao utilDao;

	@Override
	public List<CodeModel> selCode(String cdGroupId) {
		return codeDao.selCode(cdGroupId);
	}

	@Override
	public String selTenantIdSeq() {
		return CommonUtil.concatString(CommonUtil.getCurrentDate(CommonEnums.ONLY_YEAR_FORMAT.getValue()), CommonUtil.getPaddingZero(CommonEnums.DEFAULT_LENGTH_FOR_ZERO.getValue(), utilDao.selTenantIdSeq()));
	}
	
}