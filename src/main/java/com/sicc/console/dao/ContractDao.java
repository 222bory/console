package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ContractModel;

public interface ContractDao {
	public List<ContractExtModel> selListContract(ContractExtModel contractExtModel); 
	
	public void insContract(ContractModel contractModel) ; 
	
}

