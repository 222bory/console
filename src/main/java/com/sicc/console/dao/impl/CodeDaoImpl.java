package com.sicc.console.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;

import com.sicc.console.dao.CodeDao;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.MonitorModel;

public class CodeDaoImpl implements CodeDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	@Cacheable(value = "code", key="#cdGroupId")
	public List<CodeModel> selCode(String cdGroupId) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.CodeDao.selCode", cdGroupId);
	}
	
	@Override
	@Cacheable(value = "code", key="#cdGroupId.concat(#cdId)")
	public String selCodeByCdId(String cdGroupId, String cdId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cdGroupId", cdGroupId);
		map.put("cdId", cdId);
		return sqlSessionTemplate.selectOne("com.sicc.console.dao.CodeDao.selCodeByCdId", map);
	}
	
	@Override
	public List<CodeModel> selListCode(CodeModel codeModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.CodeDao.selListCode", codeModel);
	}
	
	@Override
	public List<CodeModel> selCode(CodeModel codeModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.CodeDao.selCode", codeModel);
	}
	
	@Override
	public void insCodeMaster(CodeModel codeModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.CodeDao.insCodeMaster", codeModel);
	}
	
	@Override
	public void insCodeDetail(CodeModel codeModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.CodeDao.insCodeDetail", codeModel);
	}
	
	@Override
	public void delCodeMaster(CodeModel codeModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.CodeDao.delCodeMaster", codeModel);
	}
	
	@Override
	public void delCodeDetail(CodeModel codeModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.CodeDao.delCodeDetail", codeModel);
	}

}

