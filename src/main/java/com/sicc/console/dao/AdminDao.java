package com.sicc.console.dao;

import java.util.List;
import com.sicc.console.model.AdminModel;
import com.sicc.console.model.Member;

//@Mapper
public interface AdminDao {
	public Member getUser(String username);
	
	public void createMember(Member member) ;
	
	public void insertAdminUser(Member member);
	
	public Member getMemberById(String id);

	public List<Member> getMember();

	public List<AdminModel> selectListAdmin(AdminModel adminModel); 

}

