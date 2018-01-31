package com.sicc.console.dao;

import com.sicc.console.model.Member;

public interface CommonDao {
	
	public Member getMember();
	public void insertAdminUserH(Member member);
}

