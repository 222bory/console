package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.AdminDao;
import com.sicc.console.model.AdminModel;
import com.sicc.console.model.Member;
import com.sicc.console.service.AdminService; 


@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDao adminDao;
	
	public List<AdminModel> selectListAdmin(AdminModel adminModel){
		return adminDao.selectListAdmin(adminModel);
	}

	@Override
	public Member findByUserNameOrEmail(String username) {
		return adminDao.getMemberById(username);
	}
	
	@Override
	public void insAdmin(AdminModel adminModel) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		adminModel.setPassword(passwordEncoder.encode(adminModel.getPassword()));
		
		adminDao.insAdmin(adminModel);
	}

	@Override
	public void delAdmin(String adminId) {
		adminDao.delAdmin(adminId);
	};
	
}
