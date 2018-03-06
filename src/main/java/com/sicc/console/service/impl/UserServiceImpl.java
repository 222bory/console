package com.sicc.console.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import com.sicc.console.dao.AdminDao;
import com.sicc.console.model.Member;
import com.sicc.console.service.UserService;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{
	
	/*@Autowired
	private AdminDao adminDao;


    public Member findByUserNameOrEmail(String username) {

        return adminDao.getMemberById(username);

    }

	@Override
	public void iniDataForTesting() {
		
	}
	
	@Override
	public void createMember(Member member) {

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		
		adminDao.insertAdminUser(member);
		System.out.println("service completed...........");
	}

	@Override
	public List<Member> getMember() {
		
		return adminDao.getMember();
	}*/
}
