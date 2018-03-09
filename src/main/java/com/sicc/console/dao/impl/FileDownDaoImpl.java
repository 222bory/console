package com.sicc.console.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.FileDownDao;

public class FileDownDaoImpl implements FileDownDao{

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<String> selTenantIdByAllData(String tenantId) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.FileDownDao.selTenantIdByAllData", tenantId);
	}

	@Override
	public List<String> selTenantList() {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.FileDownDao.selTenantList");
	}

}
