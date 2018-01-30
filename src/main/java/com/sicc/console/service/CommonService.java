package com.sicc.console.service;

import java.util.List;

import com.sicc.console.model.Member;
import com.sicc.console.model.User2;

public interface CommonService {

    public Member getMember();
    
    public void insertAdminUserH(Member member) ;
}
