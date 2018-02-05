package com.sicc.console.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.CodeModel;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.ServiceApplyService;

@Controller
public class ServiceApplyController {
	
	private final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	ServiceApplyService serviceApplyService;
	
	@Autowired
	CommonService commonService;
	
	
    @GetMapping("/insServiceApply") 
    public String insServiceApply(Model model) {
    	List<CodeModel> serviceList = commonService.selCode(CommonEnums.SERVICE_CD.getValue());
    	
    	List<CodeModel> languageList = commonService.selCode(CommonEnums.LANG_CD.getValue());

    	model.addAttribute("serviceList",serviceList);
    	model.addAttribute("languageList",languageList);
    	
        return "/service/insServiceApply";
    }
    
    
    @PostMapping("/insServiceApply")
    @Transactional(rollbackFor=Exception.class)
    public String insServiceApply(Model model,
    		@RequestParam(value="tenantId", required=true) String tenantId,
    		@RequestParam(value="cpCd", required=true) String cpCd,
    		@RequestParam(value="serviceCd", required=true) String serviceCd,
    		@RequestParam(value="serviceStartDt", required=true) String serviceStartDt,
    		@RequestParam(value="serviceEndDt", required=true) String serviceEndDt,
    		@RequestParam(value="serviceUrlAddr", required=false) String serviceUrlAddr,
    		@RequestParam(value="repColorCd", required=false) String repColorCd,
    		@RequestParam(value="fstLangCd", required=false) String fstLangCd,
    		@RequestParam(value="scndLangCd", required=false) String scndLangCd,
    		@RequestParam(value="thrdLangCd", required=false) String thrdLangCd,
    		@RequestParam(value="fothLangCd", required=false) String fothLangCd,
    		@RequestParam(value="fithLangCd", required=false) String fithLangCd,
    		@RequestParam(value="testLabUseYn", required=true) String testLabUseYn,
    		@RequestParam(value="testLabRemarkDesc", required=false) String testLabRemarkDesc,
    		@RequestParam(value="testEventAddYn", required=true) String testEventAddYn,
    		@RequestParam(value="testEventRemarkDesc", required=false) String testEventRemarkDesc,
    		@RequestParam(value="crtId", required=false) String crtId,
    		@RequestParam(value="crtIp", required=false) String crtIp,
    		@RequestParam(value="udtId", required=false) String udtId,
    		@RequestParam(value="udtIp", required=false) String udtIp,
    		HttpServletRequest req, HttpServletResponse res) {
    	
    	
    	return "";
    }
	

}
