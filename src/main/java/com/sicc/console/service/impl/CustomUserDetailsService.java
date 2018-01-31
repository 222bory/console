package com.sicc.console.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.AdminDao;
import com.sicc.console.model.Member;
import com.sicc.console.model.SecurityMember;

import java.util.List;
import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	private AdminDao adminDao;


/*    public List<User2> findByUserNameOrEmail(String username) {

        return adminDao.getUser(username);

    }*/

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		
		Member member = adminDao.getMemberById(id);
		if(member == null) {
			throw new UsernameNotFoundException(id);
		}
		
		return Optional.ofNullable(adminDao.getMemberById(id))
				.filter(m -> m!= null)
				.map(m -> new SecurityMember(m)).get();
		
	}
}
