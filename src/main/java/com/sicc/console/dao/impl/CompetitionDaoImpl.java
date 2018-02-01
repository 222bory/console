package com.sicc.console.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.sicc.console.dao.CompetitionDao;
import com.sicc.console.model.CompetitionModel;

public class CompetitionDaoImpl implements CompetitionDao{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void insCompetition(CompetitionModel competitionModel) {
		sqlSessionTemplate.insert("com.sicc.console.dao.CompetitionDao.insCompetition", competitionModel);
	}

	@Override
	public void upCompetition(CompetitionModel competitionModel) {
		sqlSessionTemplate.update("com.sicc.console.dao.CompetitionDao.upCompetition", competitionModel);
	}
}

