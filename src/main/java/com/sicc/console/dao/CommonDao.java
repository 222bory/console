package com.sicc.admin.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.sicc.admin.common.WithHist;
import com.sicc.admin.model.Member;
import com.sicc.admin.model.MemberRole;
import com.sicc.admin.model.MemberRoleRel;
import com.sicc.admin.model.User2;

//@Mapper
public interface CommonDao {
	
	public Member getMember();
	public void insertAdminUserH(Member member);
}

