package com.sicc.console.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.ContractDao;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ContractModel;

public class ContractDaoImpl implements ContractDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<ContractExtModel> selListContract(ContractExtModel contractExtModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.ContractDao.selListContract", contractExtModel);
	}
	@Override
	public List<ContractExtModel> selListContractCnt(ContractExtModel contractExtModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.ContractDao.selListContractCnt", contractExtModel);
	}
	@Override
	public List<ContractExtModel> selListCustCnt(ContractExtModel contractExtModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.ContractDao.selListCustCnt", contractExtModel);
	}
	@Override
	public List<ContractExtModel> selListCust(ContractExtModel contractExtModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.ContractDao.selListCust", contractExtModel);
	}
	@Override
	public ContractExtModel selContract(ContractExtModel contractExtModel) {
		return sqlSessionTemplate.selectOne("com.sicc.console.dao.ContractDao.selContract", contractExtModel);
	}
	@Override
	public void insContract(ContractModel contractModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.ContractDao.insContract", contractModel);
	}
	@Override
	public void delCust(ContractExtModel contractExtModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.ContractDao.delCust", contractExtModel);
	}
	@Override
	public void delContract(ContractExtModel contractExtModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.ContractDao.delContract", contractExtModel);
	}
	@Override
	public void upCust(ContractExtModel contractExtModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.ContractDao.upCust", contractExtModel);
	}
	@Override
	public void upContract(ContractExtModel contractExtModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.ContractDao.upContract", contractExtModel);
	}
}

