package com.sicc.admin.demo.service.impl;

import com.sicc.admin.demo.dao.AdminDao;
import com.sicc.admin.demo.model.Member;
import com.sicc.admin.demo.model.MemberRole;
import com.sicc.admin.demo.model.MemberRoleRel;
import com.sicc.admin.demo.model.User2;
import com.sicc.admin.demo.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private AdminDao adminDao;


    public Member findByUserNameOrEmail(String username) {

        return adminDao.getMemberById(username);

    }

	@Override
	public void iniDataForTesting() {
		
	}

	
	@Override
	public void createMember(Member member) {
		/*List<MemberRole> roleList = new ArrayList<MemberRole>();
		MemberRole role = new MemberRole();
		MemberRole role2 = new MemberRole();
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		member.setUpw(passwordEncoder.encode(member.getUpw()));
		role.setRno(Long.parseLong("1"));
		role2.setRno(Long.parseLong("2"));
		role.setRolename("BASIC");
		role2.setRolename("ADMIN");
		
		roleList.add(role);
		roleList.add(role2);
		
		
		member.setRoles(roleList);
		adminDao.createMember(member);
		
		for(int i = 0 ; i < roleList.size() ; i ++) {
			MemberRoleRel rel = new MemberRoleRel();
			rel.setUid(member.getUid());
			rel.setRno(roleList.get(i).getRno());
			rel.setMemberRoleRelTypeCd("SU");
			
			adminDao.createRelMemberRole(rel);
			//adminDao.createRole(roleList.get(i));
		}*/
	}
}
