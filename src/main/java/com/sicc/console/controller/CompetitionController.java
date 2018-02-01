package com.sicc.console.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger; 
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sicc.console.model.CompetitionModel;
import com.sicc.console.service.CompetitionService;
import com.sicc.console.service.UserService;
import com.sicc.console.service.impl.CustomUserDetailsService;

@Controller
public class CompetitionController { 

    //private final Logger logger = LoggerFactory.getLogger(ContController.class);

    @Autowired
    CompetitionService competitionService;
    

    @GetMapping("/insCompetition") 
    public String insCompetition() {
        return "/competition/insCompetition";
    }
    
    @PostMapping("/insCompetition")
    @Transactional(rollbackFor=Exception.class)
    public String insCompetition(Model model , 
    		@RequestParam(value="tenantId", required=true) String tenantId, 
    		@RequestParam("cpCd") String cpCd, 
    		@RequestParam("cpNm") String cpNm,
    		@RequestParam("cpStartDt") String cpStartDt,
    		@RequestParam("cpEndDt") String cpEndDt,
    		@RequestParam("cpPlaceNm") String cpPlaceNm,
    		@RequestParam("cpScaleCd") String cpScaleCd,
    		@RequestParam("cpTypeCd") String cpTypeCd,
    		@RequestParam("expectUserNum") String expectUserNum,
    		HttpServletRequest req, HttpServletResponse res) {
		
    	
    	System.out.println(tenantId+" "+cpCd+" "+cpNm+" "+cpStartDt +" "+cpEndDt +" "+cpPlaceNm +" "+
    			cpScaleCd +" "+cpTypeCd +" "+expectUserNum );
    	
    	CompetitionModel competitionModel= new CompetitionModel();
    	
    	competitionModel.setTenantId("t"+System.currentTimeMillis());
    	competitionModel.setCpCd(cpCd);
    	competitionModel.setCpNm(cpNm);
    	competitionModel.setCpStartDt(cpStartDt);
    	competitionModel.setCpEndDt(cpEndDt);
    	competitionModel.setCpPlaceNm(cpPlaceNm);
    	competitionModel.setCpScaleCd(cpScaleCd);
    	competitionModel.setCpTypeCd(cpTypeCd);
    	competitionModel.setExpectUserNum(Integer.parseInt(expectUserNum));
    	competitionModel.setCrtId("test");
    	competitionModel.setCrtIp(req.getRemoteAddr());
    	competitionModel.setUdtId("test");
    	competitionModel.setUdtIp(req.getRemoteAddr());
    	
    	competitionService.insCompetition(competitionModel);
    	
    	
    	return "/competition/insCompetition";
    	
    }
    
    @GetMapping("/upCompetition") 
    public String upCompetition() {
        return "/competition/upCompetition";
    }
    
    @PostMapping("/upCompetition")
    @Transactional(rollbackFor=Exception.class)
    public String upCompetition(Model model , 
    		@RequestParam(value="tenantId", required=true) String tenantId, 
    		@RequestParam("cpCd") String cpCd, 
    		@RequestParam("cpNm") String cpNm,
    		@RequestParam("cpStartDt") String cpStartDt,
    		@RequestParam("cpEndDt") String cpEndDt,
    		@RequestParam("cpPlaceNm") String cpPlaceNm,
    		@RequestParam("cpScaleCd") String cpScaleCd,
    		@RequestParam("cpTypeCd") String cpTypeCd,
    		@RequestParam("expectUserNum") String expectUserNum,
    		HttpServletRequest req, HttpServletResponse res) {
		
    	
    	System.out.println(tenantId+" "+cpCd+" "+cpNm+" "+cpStartDt +" "+cpEndDt +" "+cpPlaceNm +" "+
    			cpScaleCd +" "+cpTypeCd +" "+expectUserNum );
    	
    	CompetitionModel competitionModel= new CompetitionModel();
    	
    	competitionModel.setTenantId("t1517446536049");
    	competitionModel.setCpCd(cpCd);
    	competitionModel.setCpNm(cpNm);
    	competitionModel.setCpStartDt(cpStartDt);
    	competitionModel.setCpEndDt(cpEndDt);
    	competitionModel.setCpPlaceNm(cpPlaceNm);
    	competitionModel.setCpScaleCd(cpScaleCd);
    	competitionModel.setCpTypeCd(cpTypeCd);
    	competitionModel.setExpectUserNum(Integer.parseInt(expectUserNum));
    	competitionModel.setCrtId("test");
    	competitionModel.setCrtIp(req.getRemoteAddr());
    	competitionModel.setUdtId("test");
    	competitionModel.setUdtIp(req.getRemoteAddr());
    	
    	competitionService.upCompetition(competitionModel);
    	
    	
    	return "/competition/upCompetition";
    	
    }
    

}