package com.sicc.console.service;

import java.util.List;

import com.sicc.console.model.CodeModel;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceExtModel;
import com.sicc.console.model.ServiceModel;

public interface ServiceApplyService {
	public void insServiceApply(ServiceModel serviceModel);
	
	public void insServiceApplyDetail(ServiceDetailModel serviceDetailModel);

	public List<ServiceExtModel> selListServiceApply(ServiceModel serviceModel);
	
	public List<ServiceExtModel> selServiceApply(ServiceModel serviceModel);
	
	public List<ServiceDetailModel> selServiceApplyDetail(ServiceModel serviceModel);
	
	public void delServiceApply(ServiceModel serviceModel);
	
	public void delServiceApplyDetail(ServiceDetailModel serviceDetailModel);
	
	public List<CodeModel> selSystemList();

}
