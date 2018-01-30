package com.sicc.console.service;

import java.util.List;

import com.sicc.console.model.AdminModel;

public interface AdminService {

    public List<AdminModel> selectListAdmin(AdminModel adminModel);
    
}
