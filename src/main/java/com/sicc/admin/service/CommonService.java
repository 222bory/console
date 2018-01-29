package com.sicc.admin.service;

import java.util.List;

import com.sicc.admin.model.Member;
import com.sicc.admin.model.User2;

public interface CommonService {

    public Member getMember();
    
    public void insertAdminUserH(Member member) ;
}
