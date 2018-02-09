package com.sicc.console.service;

import java.util.List;

import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ContractModel;
import com.sicc.console.model.CustomerModel;

public interface ContractService {
	
	public List<ContractExtModel> selListContract(ContractExtModel contractExtModel); 
	
	public List<ContractExtModel> selListContractCnt(ContractExtModel contractExtModel);
	
	public List<ContractExtModel> selListCustCnt(ContractExtModel contractExtModel);
	
	public List<ContractExtModel> selListCust(ContractExtModel contractExtModel);
	
	public ContractExtModel selContract(ContractExtModel contractExtModel);
	
    public void insCustomer(CustomerModel customerModel) ;
    
    public void insContract(ContractModel contractModel) ;
    
    public void delCust(ContractExtModel contractExtModel);
	
	public void delContract(ContractExtModel contractExtModel);
    
}
