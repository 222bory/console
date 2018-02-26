package com.sicc.console.dao;

import java.util.List;

import com.sicc.console.model.MonitorModel;

public interface MonitorDao {  
	
	public MonitorModel selMonitor(MonitorModel monitorModel);
	
	public List<MonitorModel> selListMonitor(MonitorModel monitorModel);
	
	public void insMonitor(MonitorModel monitorModel);
	
	public void delMonitor(MonitorModel monitorModel);
	
	public void upMonitor(MonitorModel monitorModel);

}

