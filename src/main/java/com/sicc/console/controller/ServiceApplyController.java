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
import com.sicc.console.model.CompetitionExtModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ServiceDetailModel;
import com.sicc.console.model.ServiceExtModel;
import com.sicc.console.model.ServiceModel;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.CompetitionService;
import com.sicc.console.service.ServiceApplyService;

@Controller
public class ServiceApplyController {
	
	private final Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@Autowired
	ServiceApplyService serviceApplyService;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	CompetitionService competitionService;
	
    private Integer rowPerPage = 10;
	
    @ResponseBody
    @RequestMapping("/searchCompetitionService")
    public List<CompetitionModel> searchCompetitionService(Model model,
    		 @RequestParam(value="searchType", required=false) String searchType, 
    		 @RequestParam(value="searchValue", required=false) String searchValue){
    	
    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<CompetitionModel> competitionList = commonService.searchCompetition(searchType, searchValue);
    	
    	return competitionList;
    }
    
    
    
    @GetMapping("/insServiceApply") 
    public String insServiceApply(Model model,
    	 @RequestParam(value="searchType", required=false) String searchType, 
   		 @RequestParam(value="searchValue", required=false) String searchValue){
    	List<CodeModel> serviceList = commonService.selCode(CommonEnums.SERVICE_CD.getValue());
    	List<CodeModel> languageList = commonService.selCode(CommonEnums.LANG_CD.getValue());

    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<CompetitionModel> competitionList = commonService.searchCompetition(searchType, searchValue);
    	
    	model.addAttribute("competitionList",competitionList);
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
    public String insServiceApply(Model model,
    		@RequestParam(value="tenantId", required=true) String tenantId,
    		@RequestParam(value="cpCd", required=true) String cpCd,
    		@RequestParam(value="serviceCd", required=true) String[] serviceCd,
    		@RequestParam(value="systemCd", required=true) String[] systemCd,
    		@RequestParam(value="serviceStartDt", required=true) String[] serviceStartDt,
    		@RequestParam(value="serviceEndDt", required=true) String[] serviceEndDt,
    		@RequestParam(value="serviceUrlAddr", required=false, defaultValue="" ) String[] serviceUrlAddr,
    		@RequestParam(value="testLabUseYn", required=true) String[] testLabUseYn,
    		@RequestParam(value="testLabRemarkDesc", required=false, defaultValue="") String[] testLabRemarkDesc,
    		@RequestParam(value="testEventAddYn", required=true) String[] testEventAddYn,
    		@RequestParam(value="testEventRemarkDesc", required=false, defaultValue="") String[] testEventRemarkDesc,
    		@RequestParam(value="serviceCdD", required=true) String[] serviceCdD,
    		@RequestParam(value="repColorValue", required=false) String[] repColorValue,
    		@RequestParam(value="fstLangCd", required=false) String[] fstLangCd,
    		@RequestParam(value="scndLangCd", required=false) String[] scndLangCd,
    		@RequestParam(value="thrdLangCd", required=false) String[] thrdLangCd,
    		@RequestParam(value="fothLangCd", required=false) String[] fothLangCd,
    		@RequestParam(value="fithLangCd", required=false) String[] fithLangCd,
    		HttpServletRequest req, HttpServletResponse res) {
    	
    		System.out.println("tenantId --> "+tenantId +", cpCd --> "+cpCd);
    	
	    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    	String crtId = principal.getUsername(); //현재 사용자
	    	String crtIp = req.getRemoteAddr(); //현재 사용자 ip
	    	
	    	ServiceModel serviceModel = new ServiceModel();
	    	ServiceDetailModel serviceDetailModel = new ServiceDetailModel();
    	
	    	int upCount=0;
	    	int downCount=0;

    		System.out.println("serviceCd.length-->"+serviceCd.length);
    		System.out.println("serviceCdD.length-->"+serviceCdD.length);
    		
    		
    		serviceModel.setTenantId(tenantId);
    		serviceModel.setCpCd(cpCd);
    		
    		List<ServiceExtModel> service= serviceApplyService.selServiceApply(serviceModel);

    		if(service.size() == 0) {
		    	for(int i=0; i < serviceCd.length; i++) {
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
			    				serviceModel.setRepColorValue(repColorValue[j]);
			    				serviceModel.setFstLangCd(fstLangCd[j]);
			    				serviceModel.setScndLangCd(scndLangCd[j]);
			    				serviceModel.setThrdLangCd(thrdLangCd[j]);
			    				serviceModel.setFothLangCd(fothLangCd[j]);
			    				serviceModel.setFithLangCd(fithLangCd[j]);
			    			}
		    			}
		    			
		    			serviceModel.setCrtId(crtId);
		    			serviceModel.setCrtIp(crtIp);
		    			serviceModel.setUdtId(crtId);
		    			serviceModel.setUdtIp(crtIp);
		    			
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
		    			serviceDetailModel.setUdtId(crtId);
		    			serviceDetailModel.setUdtIp(crtIp);
		    			
		    			serviceApplyService.insServiceApplyDetail(serviceDetailModel);
		    			downCount++;
		    		}
		    	}
		    	System.out.println("upCount --> "+upCount);
		    	System.out.println("downCount --> "+downCount);
		    	
		    	model.addAttribute("result", "1");
    		}
    		else if(service.size() > 0){
    			model.addAttribute("result", "dupl");
    		}
    		else {
    			model.addAttribute("result", "0");
    		}
	    	
    	return "jsonView";
    }
	

    @RequestMapping("/selListServiceApply")
    public String selListServiceApply(@RequestParam Map<String, String> param, 
    		Model model, 
    		ServiceModel serviceModel,
    		@RequestParam(value="searchGroup" , required=false) String searchGroup,
    		@RequestParam(value="searchNm" , required=false) String searchNm,
    		HttpServletRequest req, HttpServletResponse res) {
    	
    	String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
    	serviceModel.setRowPerPage(rows);
    	serviceModel.setPage(NumberUtils.toInt(page));
    	serviceModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
    	
    	if(searchGroup != null) {
	    	if(searchGroup.equals("searchCpCd")) {
	    		serviceModel.setSearchCpCd(searchNm);
	    	}
	    	else if(searchGroup.equals("searchCpNm")) {
	    		serviceModel.setSearchCpNm(searchNm);
	    	}
    	}
    	
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
    
    
    @RequestMapping("/selServiceApply")
    public String selServiceApply(@RequestParam Map<String,String> param,
				@RequestParam(value="tenantId", required=true) String tenantId,
				@RequestParam(value="cpCd", required=true) String cpCd,
				Model model, ServiceModel serviceModel,
				HttpServletRequest req, HttpServletResponse res) {
    	List<CodeModel> serviceList = commonService.selCode(CommonEnums.SERVICE_CD.getValue());
    	List<CodeModel> languageList = commonService.selCode(CommonEnums.LANG_CD.getValue());
    	
    	serviceModel.setTenantId(tenantId);
    	serviceModel.setCpCd(cpCd);
    	
    	CompetitionModel competitionModel = new CompetitionModel();
    	competitionModel.setTenantId(tenantId);
    	competitionModel.setCpCd(cpCd);
    	//대회정보
    	CompetitionExtModel competition = competitionService.selCompetition(competitionModel);

    	//서비스정보
    	List<ServiceExtModel> selServiceApply = serviceApplyService.selServiceApply(serviceModel);
    	//하위서비스정보
    	List<ServiceDetailModel> selServiceApplyDetail = serviceApplyService.selServiceApplyDetail(serviceModel);

    	model.addAttribute("serviceList", serviceList);
    	model.addAttribute("languageList", languageList);
    	model.addAttribute("competition",competition);
    	model.addAttribute("selServiceApply",selServiceApply);
    	model.addAttribute("selServiceApplyDetail",selServiceApplyDetail);
    	
    	return "/service/selServiceApply";
    }
    
    
    @RequestMapping("/delServiceApply")
    @Transactional(rollbackFor=Exception.class)
    public String delServiceApply(@RequestParam Map<String,String> param,
    				@RequestParam(value="tenantId", required=true) String tenantId,
    				@RequestParam(value="cpCd", required=true) String cpCd,
    				@RequestParam(value="serviceCd", required=true) String[] serviceCd,
    				@RequestParam(value="serviceCdd", required=false) String[] serviceCdd,
    				@RequestParam(value="systemCd", required=false) String[] systemCd,
 					Model model) {
    	String result = "";
    	ServiceModel serviceModel = new ServiceModel();
    	ServiceDetailModel serviceDetailModel = new ServiceDetailModel();
    	
    	if(serviceCdd == null) {
    		serviceCdd = new String[0];
    	}
    	if(systemCd == null) {
    		systemCd = new String[0];
    	}
    	
    	try {
    		if(serviceCdd.length > 0) {
	    		for(int i=0 ; i< serviceCdd.length ; i++) {
	    			serviceDetailModel.setTenantId(tenantId);
	    			serviceDetailModel.setCpCd(cpCd);
	    			serviceDetailModel.setServiceCd(serviceCdd[i]);
	    			serviceDetailModel.setSystemCd(systemCd[i]);
	    			
	        		serviceApplyService.delServiceApplyDetail(serviceDetailModel);
	        		System.out.println("하위서비스 삭제 완료!");
	    		}
    		}
    		if(serviceCd.length > 0) {
	    		for(int i=0 ; i< serviceCd.length ; i++) {
	    			serviceModel.setTenantId(tenantId);
	    			serviceModel.setCpCd(cpCd);
	    			serviceModel.setServiceCd(serviceCd[i]);
	
	    			serviceApplyService.delServiceApply(serviceModel);
	        		System.out.println("상위서비스 삭제 완료!");
	    		}
	    		
	    		result = "1";
    		}
    	}
    	catch(Exception e){
    		result = "0";
    	}
    	
    	model.addAttribute("result", result);
    	
    	return "jsonView";
    }
    
    
    
    @RequestMapping("/upServiceApplyForm")
    public String upServiceApply(@RequestParam Map<String, String> param,
				@RequestParam(value="tenantId", required=true) String tenantId,
				@RequestParam(value="cpCd", required=true) String cpCd,
				Model model, HttpServletRequest req, HttpServletResponse res) 
    		{
		    	List<CodeModel> serviceList = commonService.selCode(CommonEnums.SERVICE_CD.getValue());
		    	List<CodeModel> languageList = commonService.selCode(CommonEnums.LANG_CD.getValue());
		    	
		    	ServiceModel serviceModel = new ServiceModel();
		    	serviceModel.setTenantId(tenantId);
		    	serviceModel.setCpCd(cpCd);
		    	
		    	CompetitionModel competitionModel = new CompetitionModel();
		    	competitionModel.setTenantId(tenantId);
		    	competitionModel.setCpCd(cpCd);
		    	
		    	//대회정보
		    	CompetitionExtModel competition = competitionService.selCompetition(competitionModel);
		
		    	//서비스정보
		    	List<ServiceExtModel> selServiceApply = serviceApplyService.selServiceApply(serviceModel);
		    	//하위서비스정보
		    	List<ServiceDetailModel> selServiceApplyDetail = serviceApplyService.selServiceApplyDetail(serviceModel);

		    	model.addAttribute("serviceList", serviceList);
		    	model.addAttribute("languageList", languageList);
		    	model.addAttribute("competition",competition);
		    	model.addAttribute("selServiceApply",selServiceApply);
		    	model.addAttribute("selServiceApplyDetail",selServiceApplyDetail);
		    	
		    	return "/service/upServiceApply";	
    		}
    
    @PostMapping("/upServiceApply")
    @Transactional(rollbackFor=Exception.class)
    public String upServiceApply(Model model,
	    		@RequestParam(value="tenantId", required=true) String tenantId, 
	    		@RequestParam(value="cpCd", required=true) String cpCd,
	    		@RequestParam(value="serviceCd", required=true) String[] serviceCd,
	    		@RequestParam(value="systemCd", required=true) String[] systemCd,
	    		@RequestParam(value="serviceStartDt", required=true) String[] serviceStartDt,
	    		@RequestParam(value="serviceEndDt", required=true) String[] serviceEndDt,
	    		@RequestParam(value="serviceUrlAddr", required=false, defaultValue="" ) String[] serviceUrlAddr,
	    		@RequestParam(value="testLabUseYn", required=true) String[] testLabUseYn,
	    		@RequestParam(value="testLabRemarkDesc", required=false, defaultValue="") String[] testLabRemarkDesc,
	    		@RequestParam(value="testEventAddYn", required=true) String[] testEventAddYn,
	    		@RequestParam(value="testEventRemarkDesc", required=false, defaultValue="") String[] testEventRemarkDesc,
	    		@RequestParam(value="serviceCdD", required=true) String[] serviceCdD,
	    		@RequestParam(value="repColorValue", required=false) String[] repColorValue,
	    		@RequestParam(value="fstLangCd", required=false) String[] fstLangCd,
	    		@RequestParam(value="scndLangCd", required=false) String[] scndLangCd,
	    		@RequestParam(value="thrdLangCd", required=false) String[] thrdLangCd,
	    		@RequestParam(value="fothLangCd", required=false) String[] fothLangCd,
	    		@RequestParam(value="fithLangCd", required=false) String[] fithLangCd,
	    		@RequestParam(value="serivceOriginCd", required=true) String[] serivceOriginCd,
	    		@RequestParam(value="systemOriginCd", required=true) String[] systemOriginCd,
	    		HttpServletRequest req, HttpServletResponse res) {

	    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    	String crtId = principal.getUsername(); //현재 사용자
	    	String crtIp = req.getRemoteAddr(); 	//현재 사용자 ip

	    	//기존 서비스 정보 delete
	    	try {
	    		ServiceModel serviceModel = new ServiceModel();
		    	ServiceDetailModel serviceDetailModel = new ServiceDetailModel();

		    	for(int i=0 ; i< serivceOriginCd.length ; i++) {
		    		if(!systemOriginCd[i].equals("default")) {
		    			serviceDetailModel.setTenantId(tenantId);
		    			serviceDetailModel.setCpCd(cpCd);
		    			serviceDetailModel.setServiceCd(serivceOriginCd[i]);
		    			serviceDetailModel.setSystemCd(systemOriginCd[i]);
		    			
		        		serviceApplyService.delServiceApplyDetail(serviceDetailModel);
		        		System.out.println("하위서비스 삭제 완료!");
		    		}
		    		else {
		    			serviceModel.setTenantId(tenantId);
		    			serviceModel.setCpCd(cpCd);
		    			serviceModel.setServiceCd(serivceOriginCd[i]);

		    			serviceApplyService.delServiceApply(serviceModel);
		        		System.out.println("상위서비스 삭제 완료!");		
		    		}
	    		}
	
	    		model.addAttribute("result", "1");
	    	}
	    	catch(Exception e){
	    		model.addAttribute("result", "0");
	    	}
	    	
	    	
	    //수정한 내용 insert
	    try {
	    	ServiceModel serviceModel = new ServiceModel();
	    	ServiceDetailModel serviceDetailModel = new ServiceDetailModel();
	    	
	    	for(int i=0; i < serviceCd.length; i++) {
	    		//하위서비스가 대표서비스인 경우 --> 상위서비스 insert
	    		if(systemCd[i].equals("default")){	//default = 대표서비스
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
		    				serviceModel.setRepColorValue(repColorValue[j]);
		    				serviceModel.setFstLangCd(fstLangCd[j]);
		    				serviceModel.setScndLangCd(scndLangCd[j]);
		    				serviceModel.setThrdLangCd(thrdLangCd[j]);
		    				serviceModel.setFothLangCd(fothLangCd[j]);
		    				serviceModel.setFithLangCd(fithLangCd[j]);
		    			}
	    			}
	    			serviceModel.setCrtId(crtId);
	    			serviceModel.setCrtIp(crtIp);
	    			serviceModel.setUdtId(crtId);
	    			serviceModel.setUdtIp(crtIp);
	    			
	    			serviceApplyService.insServiceApply(serviceModel);
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
	    			serviceDetailModel.setUdtId(crtId);
	    			serviceDetailModel.setUdtIp(crtIp);
	    			
	    			serviceApplyService.insServiceApplyDetail(serviceDetailModel);
	    		}
	    	}
	    	
	    	model.addAttribute("result", "1");
	    }
	    catch(Exception e) {
	    	model.addAttribute("result", "0");
	    }
	    	
    	return "jsonView";
    }

}
