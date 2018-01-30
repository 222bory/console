package com.sicc.console.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sicc.console.common.WithHist;
import com.sicc.console.dao.AdminDao;
import com.sicc.console.model.Member;
import com.sicc.console.model.MemberRole;
import com.sicc.console.model.MemberRoleRel;
import com.sicc.console.model.User2;

public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//@WithHist(sqlId = "com.sicc.admin.dao.AdminDao.insertAdminUser")
	@Override
	public void insertAdminUser(Member member) {
		
		
		sqlSessionTemplate.insert("com.sicc.admin.dao.AdminDao.insertAdminUser", member);
		
	}
	
	//exmaple
	@Override
	public Member getUser(String username) {
		
		return sqlSessionTemplate.selectOne("com.sicc.admin.dao.AdminDao.getMember");
	}

	@Override
	public void createMember(Member member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void createRole(MemberRole memberRole) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void createRelMemberRole(MemberRoleRel memberRoleRel) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Member getMemberById(String id) {
		return sqlSessionTemplate.selectOne("com.sicc.console.dao.AdminDao.getMemberById", id);
	}
	
	
}

