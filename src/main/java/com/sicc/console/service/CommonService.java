package com.sicc.console.service;

import java.util.List;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.ContractExtModel;

public interface CommonService {
    public List<CodeModel> selCode(String cdGroupId) ;
    
    public String selCodeByCdId(String cdGroupId, String cdId) ;
    
    public String selTenantIdSeq();
    
    public List<ContractExtModel> searchContract(String searchType, String searchValue);
}
