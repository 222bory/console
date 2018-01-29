package com.sicc.admin.demo.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sicc.admin.demo.model.Member;

@Mapper
public interface AdminDao {
	public Member getUser(String username);

	public void insertAdminUser(Member member);

	public Member getMemberById(String id);
}

