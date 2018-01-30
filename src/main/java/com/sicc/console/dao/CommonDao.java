package com.sicc.console.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.sicc.console.common.WithHist;
import com.sicc.console.model.Member;
import com.sicc.console.model.MemberRole;
import com.sicc.console.model.MemberRoleRel;
import com.sicc.console.model.User2;

//@Mapper
public interface CommonDao {
	
	public Member getMember();
	public void insertAdminUserH(Member member);
}

