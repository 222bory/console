package com.sicc.admin.demo.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.sicc.admin.demo.model.Member;
import com.sicc.admin.demo.model.MemberRole;
import com.sicc.admin.demo.model.MemberRoleRel;
import com.sicc.admin.demo.model.User2;

@Mapper
public interface AdminDao {
	public Member getUser(String username);
	
	public void createMember(Member member) ;
	
	public void createRole(MemberRole memberRole);
	
	public void createRelMemberRole(MemberRoleRel memberRoleRel);
	
	public void insertAdminUser(Member member);
	
	
	public Member getMemberById(String id);
}

