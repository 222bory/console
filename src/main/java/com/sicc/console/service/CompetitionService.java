package com.sicc.console.service;

import java.util.List;

import com.sicc.console.model.CompetitionExtModel;
import com.sicc.console.model.CompetitionModel;

public interface CompetitionService {

    public void insCompetition(CompetitionModel competitionModel) ;
    
    public void upCompetition(CompetitionModel competitionModel) ; 
    
    public List<CompetitionExtModel> selCompetition(CompetitionModel competitionModel);
}
