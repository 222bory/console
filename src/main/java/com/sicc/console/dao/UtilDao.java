package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.CodeModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ContractExtModel;
import java.util.HashMap;

public interface UtilDao {
	public List<CodeModel> selCode(String cdGroupId);
	
	public int selTenantIdSeq();
	
	public List<ContractExtModel> searchContract(String searchType, String searchValue);
	
	public List<CompetitionModel> searchCompetition(String searchType, String searchValue);
	
	public List<HashMap<String, String>> selListCompetitionImageMaxSeq();
}

