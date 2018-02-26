package com.sicc.console.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.MonitorDao;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.MonitorModel;

public class MonitorDaoImpl implements MonitorDao{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public MonitorModel selMonitor(MonitorModel monitorModel) {
		return sqlSessionTemplate.selectOne("com.sicc.console.dao.MonitorDao.selMonitor", monitorModel);
	}
	
	@Override
	public List<MonitorModel> selListMonitor(MonitorModel monitorModel) {
		return sqlSessionTemplate.selectList("com.sicc.console.dao.MonitorDao.selListMonitor", monitorModel);
	}
	@Override
	public void insMonitor(MonitorModel monitorModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.MonitorDao.insMonitor", monitorModel);
	}
	@Override
	public void delMonitor(MonitorModel monitorModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.MonitorDao.delMonitor", monitorModel);
	}
	@Override
	public void upMonitor(MonitorModel monitorModel) {
		sqlSessionTemplate.delete("com.sicc.console.dao.MonitorDao.upMonitor", monitorModel);
	}
}
