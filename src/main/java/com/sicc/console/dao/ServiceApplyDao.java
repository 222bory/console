package com.sicc.console.dao;

import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceModel;

public interface ServiceApplyDao {
	public void insServiceApply(ServiceModel serviceModel);
	
	public void insServiceApplyDetail(ServiceDetailModel serviceDetailModel);

}
