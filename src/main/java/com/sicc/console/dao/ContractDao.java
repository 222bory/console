package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ContractModel;

public interface ContractDao {
	public List<ContractExtModel> selListContract(ContractExtModel contractExtModel);
	//고객 인서트 체크용
	public List<ContractExtModel> selListContractCnt(ContractExtModel contractExtModel);
	//고객 딜리트 체크용
	public List<ContractExtModel> selListCustCnt(ContractExtModel contractExtModel);
	
	public List<ContractExtModel> selListCust(ContractExtModel contractExtModel);
	
	public ContractExtModel selContract(ContractExtModel contractExtModel);
	
	public void insContract(ContractModel contractModel); 
	
	public void delCust(ContractExtModel contractExtModel);
	
	public void delContract(ContractExtModel contractExtModel);
	
	public void upCust(ContractExtModel contractExtModel);
	
	public void upContract(ContractExtModel contractExtModel);
}

