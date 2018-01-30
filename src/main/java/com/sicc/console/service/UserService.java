package com.sicc.admin.service;

import java.util.List;

import com.sicc.admin.model.Member;
import com.sicc.admin.model.User2;

public interface UserService {

    public Member findByUserNameOrEmail(String username);
    
    public void iniDataForTesting();
    
    public void createMember(Member member) ;
}
