package com.sicc.admin.service.impl;

import com.sicc.admin.common.WithHist;
import com.sicc.admin.dao.AdminDao;
import com.sicc.admin.dao.CommonDao;
import com.sicc.admin.model.Member;
import com.sicc.admin.model.MemberRole;
import com.sicc.admin.model.MemberRoleRel;
import com.sicc.admin.model.User2;
import com.sicc.admin.service.CommonService;
import com.sicc.admin.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
	private CommonDao commonDao;


	@Override
	public Member getMember() {
		return commonDao.getMember();
	}

	@Override
	public void insertAdminUserH(Member member) {
		commonDao.insertAdminUserH(member);
		
	}
}
