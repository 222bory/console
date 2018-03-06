package com.sicc.console.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.sicc.console.model.AdminModel;
import com.sicc.console.model.Member;

public interface AdminService {

    public List<AdminModel> selectListAdmin(AdminModel adminModel);
    
    public Member findByUserNameOrEmail(String username);
   
    @Transactional(rollbackFor=Exception.class)
    public void insAdmin(AdminModel adminModel) ;
    
    @Transactional(rollbackFor=Exception.class)
    public void delAdmin(String adminId);
    
}
