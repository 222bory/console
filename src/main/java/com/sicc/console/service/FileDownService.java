package com.sicc.console.service;

import java.util.List;

public interface FileDownService {

    public List<String> selTenantIdByAllData(String tenantId);
    
    public List<String> selTenantList();
}
