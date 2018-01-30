package com.sicc.console.service;

import java.util.List;

import com.sicc.console.model.Member;
import com.sicc.console.model.User2;

public interface UserService {

    public Member findByUserNameOrEmail(String username);
    
    public void iniDataForTesting();
    
    public void createMember(Member member) ;
}
