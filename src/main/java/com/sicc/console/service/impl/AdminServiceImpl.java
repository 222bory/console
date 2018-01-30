package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.AdminDao;
import com.sicc.console.model.AdminModel;
import com.sicc.console.service.AdminService;


@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDao adminDao;
	
	public List<AdminModel> selectListAdmin(AdminModel adminModel){
		return adminDao.selectListAdmin(adminModel);
	};
	
}
