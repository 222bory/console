package com.sicc.console.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.common.CommonUtil;
import com.sicc.console.dao.CodeDao;
import com.sicc.console.dao.UtilDao;
import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.ContractExtModel;
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
	public String selCodeByCdId(String cdGroupId, String cdId) {
		return codeDao.selCodeByCdId(cdGroupId, cdId);
	}

	@Override
	public String selTenantIdSeq() {
		return CommonUtil.concatString(CommonUtil.getCurrentDate(CommonEnums.ONLY_YEAR_FORMAT.getValue()), CommonUtil.getPaddingZero(CommonEnums.DEFAULT_LENGTH_FOR_ZERO.getValue(), utilDao.selTenantIdSeq()));
	}

	@Override
	public List<ContractExtModel> searchContract(String searchType, String searchValue) {
		return utilDao.searchContract(searchType, searchValue);
	}
	
	
}
