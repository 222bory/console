package com.sicc.console.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;

import com.sicc.console.dao.CodeDao;
import com.sicc.console.dao.UtilDao;
import com.sicc.console.model.CodeModel;

public class UtilDaoImpl implements UtilDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<CodeModel> selCode(String cdGroupId) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.CodeDao.selCode", cdGroupId);
	}

	@Override
	public int selTenantIdSeq() {
		return sqlSessionTemplate.selectOne("com.sicc.console.dao.UtilDao.selTenantIdSeq");
	}

}

