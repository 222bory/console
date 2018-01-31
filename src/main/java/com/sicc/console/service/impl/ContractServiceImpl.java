package com.sicc.console.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.ContractDao;
import com.sicc.console.dao.CustomerDao;
import com.sicc.console.model.ContractModel;
import com.sicc.console.model.CustomerModel;
import com.sicc.console.service.ContractService;

@Service
public class ContractServiceImpl implements ContractService{
	
	@Autowired
	private CustomerDao customerDao;
	
	@Autowired
	private ContractDao contractDao;


	@Override
	public void insCustomer(CustomerModel customerModel) {
		customerDao.insCustomer(customerModel);
		
	}

	@Override
	public void insContract(ContractModel contractModel) {
		contractDao.insContract(contractModel);
		
	}

}
