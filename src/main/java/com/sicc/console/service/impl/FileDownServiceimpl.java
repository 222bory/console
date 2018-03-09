package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.FileDownDao;
import com.sicc.console.service.FileDownService;

@Service
public class FileDownServiceimpl implements FileDownService{

	@Autowired
	private FileDownDao fileDownDao;
	
	@Override
	public List<String> selTenantIdByAllData(String tenantId) {
		return fileDownDao.selTenantIdByAllData(tenantId);
	}
	
	@Override
	public List<String> selTenantList() {
		return fileDownDao.selTenantList();
	}
}
