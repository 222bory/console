package com.sicc.console.dao;

import java.util.List;
import com.sicc.console.model.AdminModel;
import com.sicc.console.model.Member;

//@Mapper
public interface AdminDao {
	public Member getUser(String username);

	public Member getMemberById(String id);

	public List<Member> getMember();

	public List<AdminModel> selectListAdmin(AdminModel adminModel); 

	public void insAdmin(AdminModel adminModel);
	
	public void delAdmin(String adminId);
}

