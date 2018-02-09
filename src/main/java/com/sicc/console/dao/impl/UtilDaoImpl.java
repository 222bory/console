package com.sicc.console.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;

import com.sicc.console.dao.CodeDao;
import com.sicc.console.dao.UtilDao;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ContractExtModel;

public class UtilDaoImpl implements UtilDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<CodeModel> selCode(String cdGroupId) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.CodeDao.selCode", cdGroupId);
	}

	@Override
	public int selTenantIdSeq() {
		return sqlSessionTemplate.selectOne("com.sicc.console.dao.UtilDao.selTenantIdSeq");
	}

	@Override
	public List<ContractExtModel> searchContract(String searchType, String searchValue) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);
		
		return sqlSessionTemplate.selectList("com.sicc.console.dao.UtilDao.searchContract", map);
	}

	@Override
	public List<CompetitionModel> searchCompetition(String searchType, String searchValue) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);

		return sqlSessionTemplate.selectList("com.sicc.console.dao.UtilDao.searchCompetition", map);
	}
	
}

