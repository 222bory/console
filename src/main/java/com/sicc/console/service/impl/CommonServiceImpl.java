package com.sicc.console.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.sicc.console.common.WithHist;
import com.sicc.console.dao.AdminDao;
import com.sicc.console.dao.CommonDao;
import com.sicc.console.model.Member;
import com.sicc.console.model.MemberRole;
import com.sicc.console.model.MemberRoleRel;
import com.sicc.console.model.User2;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.UserService;

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
