package com.sicc.console.service;

import java.util.List;
import com.sicc.console.model.CodeModel;

public interface CommonService {
    public List<CodeModel> selCode(String cdGroupId) ;
    
    public String selCodeByCdId(String cdGroupId, String cdId) ;
    
    public String selTenantIdSeq();
}
