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
import com.sicc.console.model.AdminModel;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.CompetitionExtModel;
import com.sicc.console.model.CompetitionModel; 
import com.sicc.console.service.CommonService;
import com.sicc.console.service.CompetitionService;
import com.sicc.console.service.UserService;
import com.sicc.console.service.impl.CustomUserDetailsService; 
@Controller
public class CompetitionController { 

    //private final Logger logger = LoggerFactory.getLogger(ContController.class);

    @Autowired
    CompetitionService competitionService;
    
    @Autowired
    CommonService commonService;
    
    private Integer rowPerPage = 10;
    

    @GetMapping("/insCompetition") 
    public String insCompetition(Model model) {
    	
    	List<CodeModel> cpScaleCdList = commonService.selCode("CP_SCALE_CD");
    	List<CodeModel> cpTypeCdList = commonService.selCode("CP_TYPE_CD");
    	
    	model.addAttribute("cpScaleCdList", cpScaleCdList);
    	model.addAttribute("cpTypeCdList", cpTypeCdList);
    	
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
    	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	CompetitionModel competitionModel= new CompetitionModel();
    	
    	competitionModel.setTenantId(commonService.selTenantIdSeq());
    	competitionModel.setCpCd(cpCd);
    	competitionModel.setCpNm(cpNm);
    	competitionModel.setCpStartDt(CommonUtil.removeSpecificStr(cpStartDt, CommonEnums.SLASH_MARK.getValue()));
    	competitionModel.setCpEndDt(CommonUtil.removeSpecificStr(cpEndDt, CommonEnums.SLASH_MARK.getValue()));
    	competitionModel.setCpPlaceNm(cpPlaceNm);
    	competitionModel.setCpScaleCd(cpScaleCd);
    	competitionModel.setCpTypeCd(cpTypeCd);
    	competitionModel.setExpectUserNum(Integer.parseInt(expectUserNum));
    	competitionModel.setCrtId(userId);
    	competitionModel.setCrtIp(req.getRemoteAddr());
    	competitionModel.setUdtId(userId);
    	competitionModel.setUdtIp(req.getRemoteAddr());
    	
    	competitionService.insCompetition(competitionModel);
    	
    	
    	return "/competition/insCompetition";
    	
    }
    
    @RequestMapping("/selListCompetition")
    public String selCompetition(@RequestParam Map<String, String> param, Model model, CompetitionModel competitionModel, HttpServletRequest req, HttpServletResponse res) {
    	
    	List<CodeModel> cdList = commonService.selCode("ADMIN_PRIV_CD");
    	for(int i = 0 ; i < cdList.size() ; i ++) {
    		CodeModel cd = cdList.get(i);
    		System.out.println("Code test :: "+cd.getCdGroupId());
    		System.out.println("Code test :: "+cd.getCdGroupNm());
    		System.out.println("Code test :: "+cd.getCdId());
    		System.out.println("Code test :: "+cd.getCdNm());
    		System.out.println("Code test :: "+cd.getUseYn());
    		System.out.println("---------------------------------------");
    	}
    	
    	System.out.println("ip ::: "+ req.getRemoteAddr());
    	System.out.println("tenantSeq :::: "+commonService.selTenantIdSeq());
    	
    	String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
		competitionModel.setRowPerPage(rows);
		competitionModel.setPage(NumberUtils.toInt(page));
		competitionModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
		
        List<CompetitionExtModel> competitionList = competitionService.selCompetition(competitionModel);
        
        /*for(int i = 0 ; i < competitionList.size() ; i ++) {
        	CompetitionModel cm = competitionList.get(i);
        }*/
        
        Pagination pagination = new Pagination();
		if(competitionList != null && !competitionList.isEmpty() ){
			pagination.setTotalRow(competitionList.get(0).getTotalCount()).setRowPerPage(rows).setCurrentPage(page);
		} else {
			pagination.setTotalRow(0);
		}
		
		model.addAttribute("competitionList", competitionList);
        model.addAttribute("competitionModel", competitionModel);
		model.addAttribute("pagination", pagination);
		
        return "/competition/selListCompetition";
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