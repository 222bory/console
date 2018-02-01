package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.CompetitionModel; 

public interface CompetitionDao {
	public void insCompetition(CompetitionModel competitionModel) ; 

	public void upCompetition(CompetitionModel competitionModel) ; 
	
	public List<CompetitionModel> selCompetition(CompetitionModel competitionModel);
}

