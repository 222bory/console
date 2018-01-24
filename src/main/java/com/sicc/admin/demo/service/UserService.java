package com.sicc.admin.demo.service;

import com.sicc.admin.demo.model.Member;
import com.sicc.admin.demo.model.User2;

import java.util.List;

public interface UserService {

    public Member findByUserNameOrEmail(String username);
    
    public void iniDataForTesting();
    
    public void createMember(Member member) ;
}
