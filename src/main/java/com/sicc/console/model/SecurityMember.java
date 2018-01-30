package com.sicc.admin.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class SecurityMember extends User{
	private static final String ROLE_PREFIX = "ROLE_";
	private static final long serialVersionUID = 1L;

	public SecurityMember(Member member) {
		super(member.getAdminId(), member.getPassword(), makeGrantedAuthority(member.getAdminPrivCd()));
	}
	
	/*private static List<GrantedAuthority> makeGrantedAuthority(List<MemberRole> roles){
		List<GrantedAuthority> list = new ArrayList<>();
		
		roles.forEach(role -> list.add(new SimpleGrantedAuthority(ROLE_PREFIX + role.getRolename())));
		
		return list;
	}*/
	
	private static List<GrantedAuthority> makeGrantedAuthority(String adminPrivCd){
		List<GrantedAuthority> list = new ArrayList<>();
		
		list.add(new SimpleGrantedAuthority(ROLE_PREFIX + adminPrivCd));
		
		return list;
	}

}
