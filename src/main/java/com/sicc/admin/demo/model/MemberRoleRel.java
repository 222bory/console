package com.sicc.admin.demo.model;

import java.io.Serializable;

public class MemberRoleRel  implements Serializable {
	public String uid;
	public Long rno;
	public String memberRoleRelTypeCd;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public Long getRno() {
		return rno;
	}
	public void setRno(Long rno) {
		this.rno = rno;
	}
	public String getMemberRoleRelTypeCd() {
		return memberRoleRelTypeCd;
	}
	public void setMemberRoleRelTypeCd(String memberRoleRelTypeCd) {
		this.memberRoleRelTypeCd = memberRoleRelTypeCd;
	}
	
	
	
}
