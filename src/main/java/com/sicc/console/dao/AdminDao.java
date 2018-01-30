package com.sicc.console.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.sicc.console.common.WithHist;
import com.sicc.console.model.Member;
import com.sicc.console.model.MemberRole;
import com.sicc.console.model.MemberRoleRel;
import com.sicc.console.model.User2;

//@Mapper
public interface AdminDao {
	public Member getUser(String username);
	
	public void createMember(Member member) ;
	
	public void createRole(MemberRole memberRole);
	
	public void createRelMemberRole(MemberRoleRel memberRoleRel);
	
	public void insertAdminUser(Member member);
	
	public Member getMemberById(String id);
}

