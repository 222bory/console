package com.sicc.console.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sicc.console.model.CompetitionExtModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ServiceExtModel;
import com.sicc.console.model.ServiceModel;
import com.sicc.console.service.CompetitionService;
import com.sicc.console.service.ContractService;
import com.sicc.console.service.ServiceApplyService;

@Controller
public class MainController {
	
	@Autowired
    ContractService contractService;
	
	@Autowired
	CompetitionService competitionService;
	
	@Autowired
	ServiceApplyService serviceApplyService;
	
	
	@RequestMapping("/main")
	    public String main(Model model, HttpServletRequest req, HttpServletResponse res,ContractExtModel contractExtModel,CompetitionModel competitionModel,ServiceModel serviceModel) {
		
		contractExtModel.setRowPerPage(3);
		contractExtModel.setPage(NumberUtils.toInt("1"));
		contractExtModel.setSkipCount(3 * (NumberUtils.toInt("1") - 1));
		
		competitionModel.setRowPerPage(3);
		competitionModel.setPage(NumberUtils.toInt("1"));
		competitionModel.setSkipCount(3 * (NumberUtils.toInt("1") - 1));
		
		serviceModel.setRowPerPage(3);
    	serviceModel.setPage(NumberUtils.toInt("1"));
    	serviceModel.setSkipCount(3 * (NumberUtils.toInt("1") - 1));
    	
    	
		//계약 조회
		List<ContractExtModel> list = contractService.selListContract(contractExtModel);  
        
		//대회조회
		List<CompetitionExtModel> competitionList = competitionService.selListCompetition(competitionModel);
		
		//서비스 조회
		List<ServiceExtModel> serviceList = serviceApplyService.selListServiceApply(serviceModel);
		
		model.addAttribute("Contractlist", list);
		model.addAttribute("competitionList", competitionList);
		model.addAttribute("serviceList", serviceList);
    	
    	
	    return "/main/main";
	    	
	    }
}
