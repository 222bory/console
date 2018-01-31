package com.sicc.console.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.CustomerDao;
import com.sicc.console.model.CustomerModel;

public class CustomerDaoImpl implements CustomerDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	

	@Override
	public void insCustomer(CustomerModel customerModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.CustomerDao.insCustomer", customerModel);
		
	}

}

