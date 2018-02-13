package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.ServiceApplyDao;
import com.sicc.console.model.ServiceDetailExtModel;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceExtModel;
import com.sicc.console.model.ServiceModel;
import com.sicc.console.service.ServiceApplyService;

@Service
public class ServiceApplyServiceImpl implements ServiceApplyService{

	@Autowired
	private ServiceApplyDao serviceApplyDao;
	
	
	@Override
	public void insServiceApply(ServiceModel serviceModel) {
		serviceApplyDao.insServiceApply(serviceModel);
	}

	@Override
	public void insServiceApplyDetail(ServiceDetailModel serviceDetailModel) {
		serviceApplyDao.insServiceApplyDetail(serviceDetailModel);
	}

	@Override
	public List<ServiceExtModel> selListServiceApply(ServiceModel serviceModel) {
		List<ServiceExtModel> selListServiceApply = serviceApplyDao.selListServiceApply(serviceModel);
		
		return selListServiceApply;
	}

	@Override
	public List<ServiceExtModel> selServiceApply(ServiceModel serviceModel) {
		List<ServiceExtModel> selServiceApply = serviceApplyDao.selServiceApply(serviceModel);
		return selServiceApply;
	}

	@Override
	public List<ServiceDetailExtModel> selServiceApplyDetail(ServiceModel serviceModel) {
		List<ServiceDetailExtModel> selServiceApplyDetail = serviceApplyDao.selServiceApplyDetail(serviceModel);
		return selServiceApplyDetail;
	}

}
