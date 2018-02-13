package com.sicc.console.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.ServiceApplyDao;
import com.sicc.console.model.ServiceDetailExtModel;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceExtModel;
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

	@Override
	public List<ServiceExtModel> selListServiceApply(ServiceModel serviceModel) {
		List<ServiceExtModel> selListServiceApply = 
				sqlSessionTemplate.selectList("com.sicc.console.dao.ServiceApplyDao.selListServiceApply", serviceModel);
		return selListServiceApply;
	}

	@Override
	public List<ServiceExtModel> selServiceApply(ServiceModel serviceModel) {
		List<ServiceExtModel> selServiceApply =
				sqlSessionTemplate.selectList("com.sicc.console.dao.ServiceApplyDao.selServiceApply", serviceModel);
		return selServiceApply;
	}

	@Override
	public List<ServiceDetailExtModel> selServiceApplyDetail(ServiceModel serviceModel) {
		List<ServiceDetailExtModel> selServiceApplyDetail =
				sqlSessionTemplate.selectList("com.sicc.console.dao.ServiceApplyDao.selServiceApplyDetail", serviceModel);
		return selServiceApplyDetail;
	}

}
