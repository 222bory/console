package com.sicc.console.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.ServiceApplyDao;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceModel;

public class ServiceApplyDaoImpl implements ServiceApplyDao{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insServiceApply(ServiceModel serviceModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.ServiceApplyDao.insServiceApply", serviceModel);
	}

	@Override
	public void insServiceApplyDetail(ServiceDetailModel serviceDetailModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.ServiceApplyDao.insServiceApplyDetail",serviceDetailModel);
	}

}
