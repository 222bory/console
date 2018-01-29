package com.sicc.admin.demo.model;

import java.io.Serializable;

public class MemberRole  implements Serializable {
	private Long rno;
	
	private String rolename;

	public Long getRno() {
		return rno;
	}

	public void setRno(Long rno) {
		this.rno = rno;
	}

	public String getRolename() {
		return rolename;
	}

	public void setRolename(String roleName) {
		this.rolename = roleName;
	}
	
	
}
