package com.sicc.console.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import com.sicc.console.dao.ContractDao;
import com.sicc.console.model.ContractModel;

public class ContractDaoImpl implements ContractDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insContract(ContractModel contractModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.ContractDao.insContract", contractModel);
	}

}

