package com.sicc.console.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sicc.console.dao.CompetitionDao;
import com.sicc.console.model.CompetitionExtModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.service.CompetitionService;

@Service
public class CompetitionServiceImpl implements CompetitionService{ 
	
	@Autowired
	private CompetitionDao competitionDao;
	
	@Override
	public void insCompetition(CompetitionModel competitionModel) {
		competitionDao.insCompetition(competitionModel);
	}

	@Override
	public void upCompetition(CompetitionModel competitionModel) {
		competitionDao.upCompetition(competitionModel);
	}

	@Override
	public List<CompetitionExtModel> selListCompetition(CompetitionModel competitionModel) {
		return competitionDao.selListCompetition(competitionModel);
	}
	
	@Override
	public CompetitionExtModel selCompetition(CompetitionModel competitionModel) {
		return competitionDao.selCompetition(competitionModel);
	}

	@Override
	public void delCompetition(CompetitionModel competitionModel) {
		competitionDao.delCompetition(competitionModel);
	}

}
