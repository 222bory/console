package com.sicc.console.service;

import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceModel;

public interface ServiceApplyService {
	public void insServiceApply(ServiceModel serviceModel);
	
	public void insServiceApplyDetail(ServiceDetailModel serviceDetailModel);

}
