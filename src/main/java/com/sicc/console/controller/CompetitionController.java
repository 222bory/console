package com.sicc.console.controller;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger; 
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sicc.console.common.CommonUtil;
import com.sicc.console.common.Pagination;
import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.AdminModel;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.CompetitionExtModel;
import com.sicc.console.model.CompetitionImageModel;
import com.sicc.console.model.CompetitionModel;
import com.sicc.console.model.ContractExtModel;
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
    
    @ResponseBody
    @RequestMapping("/searchCompetition") 
    public List<ContractExtModel> searchCompetition(Model model, @RequestParam(value="searchType", required=false) String searchType, @RequestParam(value="searchValue", required=false) String searchValue) {
    	
    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<ContractExtModel> contractList = commonService.searchContract(searchType, searchValue);
    	
    	//model.addAttribute("contractList", contractList);
    	
        return contractList; 
    }
    
    /*@ResponseBody
    @RequestMapping("/selListCompetitionImageMaxSeq") 
    public List<HashMap<String, String>> selListCompetitionImageMaxSeq(Model model) {
    	
    	List<HashMap<String, String>> competitionImageMaxSeqList = commonService.selListCompetitionImageMaxSeq();
    	
    	//model.addAttribute("contractList", contractList);
    	
        return competitionImageMaxSeqList; 
    }*/
    
    @GetMapping("/insCompetition") 
    public String insCompetition(Model model, @RequestParam(value="searchType", required=false) String searchType, @RequestParam(value="searchValue", required=false) String searchValue) {
    	
    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<ContractExtModel> contractList = commonService.searchContract(searchType, searchValue);
    	List<CodeModel> cpScaleCdList = commonService.selCode(CommonEnums.CP_SCALE_CD.getValue());
    	List<CodeModel> cpTypeCdList = commonService.selCode(CommonEnums.CP_TYPE_CD.getValue());
    	List<CodeModel> imgFgCdList = commonService.selCode(CommonEnums.IMG_FG_CD.getValue());
    	
    	model.addAttribute("contractList", contractList);
    	model.addAttribute("cpScaleCdList", cpScaleCdList);
    	model.addAttribute("cpTypeCdList", cpTypeCdList);
    	model.addAttribute("imgFgCdList", imgFgCdList);
    	
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
    		@RequestParam(value="imgFgCd", required=false) String imgFgCd[],
    		@RequestParam(value="imgSeq", required=false) String imgSeq[],
    		@RequestPart MultipartFile file[],
    		HttpServletRequest req, HttpServletResponse res) throws IllegalStateException, IOException {
    	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	CompetitionModel competitionModel= new CompetitionModel();
    	
    	competitionModel.setTenantId(tenantId);
    	competitionModel.setCpCd(cpCd);
    	competitionModel.setCpNm(cpNm);
    	competitionModel.setCpStartDt(CommonUtil.removeSpecificStr(cpStartDt, CommonEnums.DASH_MARK.getValue()));
    	competitionModel.setCpEndDt(CommonUtil.removeSpecificStr(cpEndDt, CommonEnums.DASH_MARK.getValue()));
    	competitionModel.setCpPlaceNm(cpPlaceNm);
    	competitionModel.setCpScaleCd(cpScaleCd);
    	competitionModel.setCpTypeCd(cpTypeCd);
    	competitionModel.setExpectUserNum(Integer.parseInt(expectUserNum));
    	competitionModel.setCrtId(userId);
    	competitionModel.setCrtIp(req.getRemoteAddr());
    	competitionModel.setUdtId(userId);
    	competitionModel.setUdtIp(req.getRemoteAddr());
    	
    	competitionService.insCompetition(competitionModel);
    	
    	
    	if(imgSeq != null) {
    		for(int i = 0 ; i < file.length ; i ++) { 
        		/*System.out.println("test ::: file originname : "+file[i].getOriginalFilename());
        		System.out.println("test ::: file contenttype : "+file[i].getContentType());
        		System.out.println("test ::: file name : "+file[i].getName());
        		System.out.println("test ::: file size : "+file[i].getSize());*/
        		
        		String sourceFileName = file[i].getOriginalFilename(); 
                String sourceFileNameExtension = FilenameUtils.getExtension(sourceFileName).toLowerCase(); 
                File destinationFile; 
                String destinationFileName;
                String fileUrl = "c://images/";
                //String fileUrl = "/images/"; 
         
                
                do {  
                    destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + sourceFileNameExtension;
                	//destinationFileName = file[i].getOriginalFilename();
                    destinationFile = new File(fileUrl + destinationFileName); 
                } while (destinationFile.exists()); 
                
                destinationFile.getParentFile().mkdirs(); 
                file[i].transferTo(destinationFile);
                
                CompetitionImageModel competitionImage = new CompetitionImageModel();
        		competitionImage.setImgFileNm(file[i].getOriginalFilename());
        		competitionImage.setSourceImgFileNm(destinationFileName);
        		competitionImage.setTenantId(tenantId);
        		competitionImage.setCpCd(cpCd);
        		competitionImage.setImgFgCd(imgFgCd[i]);
        		competitionImage.setImgSeq(Integer.parseInt(imgSeq[i]));
        		competitionImage.setFilePathNm(fileUrl);
        		competitionImage.setCrtId(userId);
        		competitionImage.setCrtIp(req.getRemoteAddr());
        		competitionImage.setUdtId(userId);
        		competitionImage.setUdtIp(req.getRemoteAddr());
        		
        		competitionService.insCompetitionImage(competitionImage);
        	} 
    	}
    	

    	return "redirect:/selListCompetition";
    	
    }
    
    @RequestMapping("/selListCompetition")
    public String selListCompetition(@RequestParam Map<String, String> param, 
    		Model model, CompetitionModel competitionModel, 
    		@RequestParam(value="searchGroup" , required=false) String searchGroup,
    		@RequestParam(value="searchNm" , required=false) String searchNm,
    		HttpServletRequest req, HttpServletResponse res) {
    	
    	String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
		competitionModel.setRowPerPage(rows);
		competitionModel.setPage(NumberUtils.toInt(page));
		competitionModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
		
		if(searchGroup != null) {
	    	if(searchGroup.equals("searchCpCd")) {
	    		competitionModel.setSearchCpCd(searchNm);
	    	}
	    	else if(searchGroup.equals("searchCpNm")) {
	    		competitionModel.setSearchCpNm(searchNm);
	    	}
	    	else if(searchGroup.equals("searchContNm")) {
	    		competitionModel.setSearchContNm(searchNm);
	    	}
    	}
		
        List<CompetitionExtModel> competitionList = competitionService.selListCompetition(competitionModel);
        
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
    
   /*@Autowired
    private  CacheManager cacheManager; */
    

    @PostMapping("/selCompetition")
    public String selCompetition(@RequestParam Map<String, String> param, 
    								@RequestParam(value="tenantId", required=true) String tenantId,
    								@RequestParam(value="cpCd", required=true) String cpCd,
    								Model model, CompetitionModel competitionModel, HttpServletRequest req, HttpServletResponse res) {

		competitionModel.setTenantId(tenantId);
		competitionModel.setCpCd(cpCd);
		
        CompetitionExtModel competition = competitionService.selCompetition(competitionModel);
        competition.setCpScaleCd(commonService.selCodeByCdId(CommonEnums.CP_SCALE_CD.getValue(), competition.getCpScaleCd()));
        competition.setCpTypeCd(commonService.selCodeByCdId(CommonEnums.CP_TYPE_CD.getValue(), competition.getCpTypeCd()));
        
        
        /*Cache cache = cacheManager.getCache("code");
        //cache.get("CP_SCALE_CD");
       System.out.println("test::::: "+cache.get("CP_SCALE_CD"));*/
        
        CompetitionImageModel competitionImage = new CompetitionImageModel();
        
        competitionImage.setTenantId(competition.getTenantId());
        competitionImage.setCpCd(competition.getCpCd());
        
        List<CompetitionImageModel> competitionImageList = competitionService.selListCompetitionImage(competitionImage);
        for(int i = 0 ; i < competitionImageList.size() ; i ++) {
        	competitionImageList.get(i).setImgFgCd(commonService.selCodeByCdId(CommonEnums.IMG_FG_CD.getValue(), competitionImageList.get(i).getImgFgCd()));
        }
		
		model.addAttribute("competition", competition);
		model.addAttribute("competitionImageList", competitionImageList);
		
        return "/competition/selCompetition";
    }
    
    /*@GetMapping("/upCompetition") 
    public String upCompetition() {
        return "/competition/upCompetition";
    }*/
    
    @GetMapping("/upCompetition") 
    public String upCompetition(Model model, @RequestParam(value="searchType", required=false) String searchType, 
    											@RequestParam(value="searchValue", required=false) String searchValue,
    											@RequestParam(value="tenantId", required=true) String tenantId,
    		    								@RequestParam(value="cpCd", required=true) String cpCd,
    		    								CompetitionModel competitionModel, HttpServletRequest req, HttpServletResponse res) {
    	
    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<ContractExtModel> contractList = commonService.searchContract(searchType, searchValue);
    	List<CodeModel> cpScaleCdList = commonService.selCode(CommonEnums.CP_SCALE_CD.getValue());
    	List<CodeModel> cpTypeCdList = commonService.selCode(CommonEnums.CP_TYPE_CD.getValue());
    	
    	HashMap<String, String> map = new HashMap<String, String>();
    	map.put("tenantId", tenantId);
    	map.put("cpCd", cpCd);
    	
    	List<HashMap<String, String>> competitionImageMaxSeqList = commonService.selListCompetitionImageMaxSeq(map);
    	
    	competitionModel.setTenantId(tenantId);
		competitionModel.setCpCd(cpCd);
		
        CompetitionExtModel competition = competitionService.selCompetition(competitionModel);
        competition.setCpScaleCd(commonService.selCodeByCdId(CommonEnums.CP_SCALE_CD.getValue(), competition.getCpScaleCd()));
        competition.setCpTypeCd(commonService.selCodeByCdId(CommonEnums.CP_TYPE_CD.getValue(), competition.getCpTypeCd()));
        
        CompetitionImageModel competitionImage = new CompetitionImageModel();
        competitionImage.setTenantId(competition.getTenantId());
        competitionImage.setCpCd(competition.getCpCd());
        
        List<CompetitionImageModel> competitionImageList = competitionService.selListCompetitionImage(competitionImage);
        for(int i = 0 ; i < competitionImageList.size() ; i ++) {
        	competitionImageList.get(i).setImgFgCd(commonService.selCodeByCdId(CommonEnums.IMG_FG_CD.getValue(), competitionImageList.get(i).getImgFgCd()));
        }
    	
        List<CodeModel> imgFgCdList = commonService.selCode(CommonEnums.IMG_FG_CD.getValue());
        
    	model.addAttribute("competition", competition);
    	model.addAttribute("contractList", contractList);
    	model.addAttribute("cpScaleCdList", cpScaleCdList);
    	model.addAttribute("cpTypeCdList", cpTypeCdList);
    	model.addAttribute("competitionImageList", competitionImageList);
    	model.addAttribute("imgFgCdList", imgFgCdList);
    	model.addAttribute("competitionImageMaxSeqList", competitionImageMaxSeqList);
    	
        return "/competition/upCompetition"; 
    }
    
    @PostMapping("/upCompetition")   
    @Transactional(rollbackFor=Exception.class)
    public String upCompetition(Model model , 
    		@RequestParam(value="tenantId", required=true) String tenantId, 
    		@RequestParam(value="cpCd", required=true) String cpCd, 
    		@RequestParam("cpNm") String cpNm,
    		@RequestParam("cpStartDt") String cpStartDt,
    		@RequestParam("cpEndDt") String cpEndDt,
    		@RequestParam("cpPlaceNm") String cpPlaceNm,
    		@RequestParam("cpScaleCd") String cpScaleCd,
    		@RequestParam("cpTypeCd") String cpTypeCd,
    		@RequestParam("expectUserNum") String expectUserNum,
    		@RequestParam(value="imgFgCd", required=false) String imgFgCd[],
    		@RequestParam(value="imgSeq", required=false) String imgSeq[],
    		@RequestPart MultipartFile file[],
    		HttpServletRequest req, HttpServletResponse res) throws IllegalStateException, IOException {
		
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	CompetitionModel competitionModel= new CompetitionModel();
    	
    	competitionModel.setTenantId(tenantId);
    	competitionModel.setCpCd(cpCd);
    	competitionModel.setCpNm(cpNm);
    	competitionModel.setCpStartDt(CommonUtil.removeSpecificStr(cpStartDt, CommonEnums.DASH_MARK.getValue()));
    	competitionModel.setCpEndDt(CommonUtil.removeSpecificStr(cpEndDt, CommonEnums.DASH_MARK.getValue()));
    	competitionModel.setCpPlaceNm(cpPlaceNm);
    	competitionModel.setCpScaleCd(cpScaleCd);
    	competitionModel.setCpTypeCd(cpTypeCd);
    	competitionModel.setExpectUserNum(Integer.parseInt(expectUserNum));
    	competitionModel.setUdtId(userId);
    	competitionModel.setUdtIp(req.getRemoteAddr());
    	
    	if(imgSeq != null) {
    		for(int i = 0 ; i < file.length ; i ++) { 
        		/*System.out.println("test ::: file originname : "+file[i].getOriginalFilename());
        		System.out.println("test ::: file contenttype : "+file[i].getContentType());
        		System.out.println("test ::: file name : "+file[i].getName());
        		System.out.println("test ::: file size : "+file[i].getSize());*/
        		
        		String sourceFileName = file[i].getOriginalFilename(); 
                String sourceFileNameExtension = FilenameUtils.getExtension(sourceFileName).toLowerCase(); 
                File destinationFile; 
                String destinationFileName;
                String fileUrl = "c://images/";
                //String fileUrl = "/images/"; 
         
                
                do {  
                    destinationFileName = RandomStringUtils.randomAlphanumeric(32) + "." + sourceFileNameExtension;
                	//destinationFileName = file[i].getOriginalFilename();
                    destinationFile = new File(fileUrl + destinationFileName); 
                } while (destinationFile.exists()); 
                
                destinationFile.getParentFile().mkdirs(); 
                file[i].transferTo(destinationFile);
                
                CompetitionImageModel competitionImage = new CompetitionImageModel();
        		competitionImage.setImgFileNm(file[i].getOriginalFilename());
        		competitionImage.setSourceImgFileNm(destinationFileName);
        		competitionImage.setTenantId(tenantId);
        		competitionImage.setCpCd(cpCd);
        		competitionImage.setImgFgCd(imgFgCd[i]);
        		competitionImage.setImgSeq(Integer.parseInt(imgSeq[i]));
        		competitionImage.setFilePathNm(fileUrl);
        		competitionImage.setCrtId(userId);
        		competitionImage.setCrtIp(req.getRemoteAddr());
        		competitionImage.setUdtId(userId);
        		competitionImage.setUdtIp(req.getRemoteAddr());
        		
        		competitionService.insCompetitionImage(competitionImage);
        	} 
    	}
    	
    	competitionService.upCompetition(competitionModel);
    	
    	
    	return "redirect:/selListCompetition";
    	
    }
    
    @PostMapping("/delCompetition")   
    @Transactional(rollbackFor=Exception.class)
    public String delCompetition(Model model , 
    		@RequestParam(value="tenantId", required=true) String tenantId, 
    		@RequestParam(value="cpCd", required=true) String cpCd, 
    		HttpServletRequest req, HttpServletResponse res) {
		
    	CompetitionModel competitionModel= new CompetitionModel();
    	competitionModel.setTenantId(tenantId);
    	competitionModel.setCpCd(cpCd);
    	
    	CompetitionImageModel competitionImageModel = new CompetitionImageModel();
    	competitionImageModel.setTenantId(tenantId);
    	competitionImageModel.setCpCd(cpCd);
    	
    	competitionService.delCompetition(competitionModel);
    	competitionService.delCompetitionImage(competitionImageModel);
    	
    	
    	return "redirect:/selListCompetition";
    	
    }
    
}