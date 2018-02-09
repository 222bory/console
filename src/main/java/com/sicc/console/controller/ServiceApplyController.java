package com.sicc.console.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sicc.console.common.CommonUtil;
import com.sicc.console.common.Pagination;
import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceExtModel;
import com.sicc.console.model.ServiceModel;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.ServiceApplyService;

@Controller
public class ServiceApplyController {
	
	private final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	ServiceApplyService serviceApplyService;
	
	@Autowired
	CommonService commonService;
	
    private Integer rowPerPage = 10;
	
    @ResponseBody
    @RequestMapping("/searchCompetitionService")
    public List<CompetitionModel> searchCompetitionService(Model model,
    		 @RequestParam(value="searchType", required=false) String searchType, 
    		 @RequestParam(value="searchValue", required=false) String searchValue){
    	
    	if(searchType == null) {
    		searchType = "N";
    	}
    	
    	List<CompetitionModel> competitionList = commonService.searchCompetition(searchType, searchValue);
    	
    	return competitionList;
    }
    
    
    
    @GetMapping("/insServiceApply") 
    public String insServiceApply(Model model) {
    	List<CodeModel> serviceList = commonService.selCode(CommonEnums.SERVICE_CD.getValue());
    	List<CodeModel> languageList = commonService.selCode(CommonEnums.LANG_CD.getValue());

    	model.addAttribute("serviceList",serviceList);
    	model.addAttribute("languageList",languageList);
    	
        return "/service/insServiceApply";
    }
    
    @ResponseBody
    @PostMapping("/selServicebySytem")
    public List<CodeModel> selServicebySytem(HttpServletRequest req, 
    		@RequestParam("serviceId") String serviceId) {

    	List<CodeModel> systemList = commonService.selCode(serviceId+"_SYSTEM_CD");
    	
    	System.out.println("systemList --> "+systemList);
    	
    	return systemList;
    }
    
    
    @PostMapping("/insServiceApply")
    @Transactional(rollbackFor=Exception.class)
    public String insServiceApply(Model model,
    		@RequestParam(value="tenantId", required=true) String tenantId,
    		@RequestParam(value="cpCd", required=true) String cpCd,
    		@RequestParam(value="serviceCd", required=true) String[] serviceCd,
    		@RequestParam(value="systemCd", required=true) String[] systemCd,
    		@RequestParam(value="serviceStartDt", required=true) String[] serviceStartDt,
    		@RequestParam(value="serviceEndDt", required=true) String[] serviceEndDt,
    		@RequestParam(value="serviceUrlAddr", required=false) String[] serviceUrlAddr,
    		@RequestParam(value="testLabUseYn", required=true) String[] testLabUseYn,
    		@RequestParam(value="testLabRemarkDesc", required=false) String[] testLabRemarkDesc,
    		@RequestParam(value="testEventAddYn", required=true) String[] testEventAddYn,
    		@RequestParam(value="testEventRemarkDesc", required=false) String[] testEventRemarkDesc,
    		@RequestParam(value="serviceCdD", required=true) String[] serviceCdD,
    		@RequestParam(value="repColorCd", required=false) String[] repColorCd,
    		@RequestParam(value="fstLangCd", required=false) String[] fstLangCd,
    		@RequestParam(value="scndLangCd", required=false) String[] scndLangCd,
    		@RequestParam(value="thrdLangCd", required=false) String[] thrdLangCd,
    		@RequestParam(value="fothLangCd", required=false) String[] fothLangCd,
    		@RequestParam(value="fithLangCd", required=false) String[] fithLangCd,
    		HttpServletRequest req, HttpServletResponse res) {
    	
	    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    	String crtId = principal.getUsername(); //현재 사용자
	    	String crtIp = req.getRemoteAddr(); //현재 사용자 ip
	    	
	    	ServiceModel serviceModel = new ServiceModel();
	    	ServiceDetailModel serviceDetailModel = new ServiceDetailModel();
    	
	    	int upCount=0;
	    	int downCount=0;
	    	
	    	for(int i=0; i<serviceCd.length; i++) {
	    		System.out.println("serviceCd.length-->"+serviceCd.length);
	    		System.out.println("serviceCdD.length-->"+serviceCdD.length);
	    		
	    		//하위서비스가 대표서비스인 경우 --> 상위서비스 insert
	    		if(systemCd[i].equals("default")){
	    			serviceModel.setTenantId(tenantId);
	    			serviceModel.setCpCd(cpCd);
	    			serviceModel.setServiceCd(serviceCd[i]);
	    			serviceModel.setServiceStartDt(CommonUtil.removeSpecificStr(serviceStartDt[i], CommonEnums.DASH_MARK.getValue()));
	    			serviceModel.setServiceEndDt(CommonUtil.removeSpecificStr(serviceEndDt[i], CommonEnums.DASH_MARK.getValue()));
	    			serviceModel.setServiceUrlAddr(serviceUrlAddr[i]);
	    			serviceModel.setTestLabUseYn(testLabUseYn[i]);
	    			serviceModel.setTestLabRemarkDesc(testLabRemarkDesc[i]);
	    			serviceModel.setTestEventAddYn(testEventAddYn[i]);
	    			serviceModel.setTestEventRemarkDesc(testEventRemarkDesc[i]);
	    			
	    			for(int j=0; j< serviceCdD.length;j++ ) {
		    			if(serviceCd[i].equals(serviceCdD[j])) {
		    				System.out.println("serviceCdD --> "+serviceCdD[j]);
		    				serviceModel.setRepColorCd(repColorCd[j]);
		    				serviceModel.setFstLangCd(fstLangCd[j]);
		    				serviceModel.setScndLangCd(scndLangCd[j]);
		    				serviceModel.setThrdLangCd(thrdLangCd[j]);
		    				serviceModel.setFothLangCd(fothLangCd[j]);
		    				serviceModel.setFithLangCd(fithLangCd[j]);
		    			}
	    			}
	    			
	    			serviceModel.setCrtId(crtId);
	    			serviceModel.setCrtIp(crtIp);
	    			
	    			serviceApplyService.insServiceApply(serviceModel);
	    			
	    			upCount++;
	    		}
	    		// 하위서비스 insert
	    		else {
	    			serviceDetailModel.setTenantId(tenantId);
	    			serviceDetailModel.setCpCd(cpCd);
	    			serviceDetailModel.setServiceCd(serviceCd[i]);
	    			serviceDetailModel.setSystemCd(systemCd[i]);
	    			serviceDetailModel.setServiceStartDt(CommonUtil.removeSpecificStr(serviceStartDt[i], CommonEnums.DASH_MARK.getValue()));
	    			serviceDetailModel.setServiceEndDt(CommonUtil.removeSpecificStr(serviceEndDt[i], CommonEnums.DASH_MARK.getValue()));
	    			serviceDetailModel.setServiceUrlAddr(serviceUrlAddr[i]);
	    			serviceDetailModel.setCrtId(crtId);
	    			serviceDetailModel.setCrtIp(crtIp);
	    			
	    			serviceApplyService.insServiceApplyDetail(serviceDetailModel);
	    			downCount++;
	    		}
	    	}
	    	System.out.println("upCount --> "+upCount);
	    	System.out.println("downCount --> "+downCount);
	    	
	    	model.addAttribute("result", "1");
	    	
    	return "jsonView";
    }
	

    @RequestMapping("/selListServiceApply")
    public String selListServiceApply(@RequestParam Map<String, String> param, Model model, 
    		ServiceModel serviceModel,HttpServletRequest req, HttpServletResponse res) {
    	
    	String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
    	serviceModel.setRowPerPage(rows);
    	serviceModel.setPage(NumberUtils.toInt(page));
    	serviceModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
    	
    	List<ServiceExtModel> serviceList = serviceApplyService.selListServiceApply(serviceModel);
    	
    	Pagination pagination = new Pagination();
		if(serviceList != null && !serviceList.isEmpty() ){
			pagination.setTotalRow(serviceList.get(0).getTotalCount()).setRowPerPage(rows).setCurrentPage(page);
		} else {
			pagination.setTotalRow(0);
		}
    	
		model.addAttribute("serviceList", serviceList);
		model.addAttribute("serviceModel", serviceModel);
		model.addAttribute("pagination", pagination);
		
    	return "/service/selListServiceApply";
    }

}
