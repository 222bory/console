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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sicc.console.common.Pagination;
import com.sicc.console.model.CodeModel;
import com.sicc.console.service.CodeService;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.MonitorService;

@Controller
public class CodeController {
	
	private Integer rowPerPage = 10;  
	
	private final Logger logger = LoggerFactory.getLogger(CodeController.class);
    
    @Autowired
    CodeService codeService;
    
    @Autowired
    CommonService commonService;
    
    @Autowired
    MonitorService monitorService;
   
    @GetMapping("/insCodeForm")
    public String insCodeForm(Model model) {
    	return "/code/insCode";
    }
    
    @RequestMapping(value="/insCode",method=RequestMethod.POST)
    @Transactional(rollbackFor=Exception.class)
    public String insCode(Model model,CodeModel codeModel,
    		@RequestParam(value="cdGroupId", required=true) String cdGroupId,
    		@RequestParam(value="cdGroupNm", required=true) String cdGroupNm,
    		@RequestParam(value="cdId", required=false) String[] cdId,
    		@RequestParam(value="cdNm", required=false) String[] cdNm,
    		HttpServletRequest req, HttpServletResponse res) throws Exception {
    	
    	//로그인정보 
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	codeModel.setCdGroupId(cdGroupId); 
    	codeModel.setCdGroupNm(cdGroupNm);
    	codeModel.setCrtId(userId);
    	codeModel.setCrtIp(req.getRemoteAddr());
    	codeModel.setUdtId(userId);
    	codeModel.setUdtIp(req.getRemoteAddr());
    	
    	//코드 마스터 등록
    	codeService.insCodeMaster(codeModel);
    	
    	for(int i=0; i<cdId.length;i++) {
    		if(!cdId[i].equals("")) { 
	    		codeModel.setCdId(cdId[i]); 
	        	codeModel.setCdNm(cdNm[i]);
	        	
	    		//코드 디테일 등록 
	    		codeService.insCodeDetail(codeModel);
    		}
    	}
    	
    	System.out.println(commonService.selCodeByCdId("qwer", "zxcv"));
    	//등록 완료 플레그 
    	model.addAttribute("result", "1");
        	
    	return "jsonView";
    	
    }
    
    @RequestMapping("/selListCode")
    public String selListCode(@RequestParam Map<String, String> param, CodeModel codeModel, Model model) {
		// 페이징 처리
		String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
		codeModel.setRowPerPage(rows);
		codeModel.setPage(NumberUtils.toInt(page));
		codeModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
    	
		System.out.println("======> serachGroup:"+param.get("serachGroup"));
		System.out.println("======> serachNm:"+param.get("serachNm"));
		
		
        List<CodeModel> list = codeService.selListCode(codeModel);  
       
        //페이징 처리
        Pagination pagination = new Pagination();
		if(list != null && !list.isEmpty() ){
			pagination.setTotalRow(list.get(0).getTotalCount()).setRowPerPage(rows).setCurrentPage(page);
		} else {
			pagination.setTotalRow(0);
		}
		
		model.addAttribute("list", list);
        model.addAttribute("codeModel", codeModel); 
		model.addAttribute("pagination", pagination);
    	
    	return "/code/selListCode";
    	
    }
    
    @RequestMapping("/selCodeView")
    public String selCodeView(@RequestParam Map<String, String> param, CodeModel codeModel, Model model) {
    	String cdGroupId = "";
    	String cdGroupNm = "";
    	
    	List<CodeModel> list = codeService.selCode(codeModel); 
    	
    	
    	
    	if(list.size() > 0) {
    		cdGroupId = list.get(0).getCdGroupId();
    		cdGroupNm = list.get(0).getCdGroupNm();
    	}
    	
    	model.addAttribute("cdGroupId", cdGroupId);
    	model.addAttribute("cdGroupNm", cdGroupNm);
    	model.addAttribute("list", list); 
    	return "/code/selCode";
    	
    }
    
    @RequestMapping("/upCodeForm")
    public String upCodeForm(@RequestParam Map<String, String> param, Model model,  CodeModel codeModel) {
    	String cdGroupId = "";
    	String cdGroupNm = "";
    	
    	List<CodeModel> list = codeService.selCode(codeModel); 
    	
    	if(list.size() > 0) {
    		cdGroupId = list.get(0).getCdGroupId();
    		cdGroupNm = list.get(0).getCdGroupNm();
    	}
    	
    	model.addAttribute("cdGroupId", cdGroupId);
    	model.addAttribute("cdGroupNm", cdGroupNm);
    	model.addAttribute("list", list); 
    	
       return "/code/upCode";
    	
    }
    
    @RequestMapping("/upCode")
    public String upCode(Model model,CodeModel codeModel,
    		@RequestParam(value="cdGroupId", required=true) String cdGroupId,
    		@RequestParam(value="cdGroupNm", required=false) String cdGroupNm,
    		@RequestParam(value="cdId", required=false) String[] cdId,
    		@RequestParam(value="cdNm", required=false) String[] cdNm,
    		HttpServletRequest req, HttpServletResponse res) {
		
		//로그인정보 
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	codeModel.setCdGroupId(cdGroupId); 
    	codeModel.setCdGroupNm(cdGroupNm);
    	codeModel.setCrtId(userId);
    	codeModel.setCrtIp(req.getRemoteAddr());
    	codeModel.setUdtId(userId);
    	codeModel.setUdtIp(req.getRemoteAddr());
    	
    	//코드 삭제 
    	codeService.delCodeDetail(codeModel);
    	
    	for(int i=0; i<cdId.length;i++) {
    		if(!cdId[i].equals("")) { 
	    		codeModel.setCdId(cdId[i]); 
	        	codeModel.setCdNm(cdNm[i]);
	        	
	    		//코드 디테일 등록
	    		codeService.insCodeDetail(codeModel);
    		}
    	}
        	//등록 완료 플레그 
        	model.addAttribute("result", "1");
    	
    	return "jsonView";
    }
    
    @RequestMapping("/delCode")
    public String delCode(@RequestParam Map<String, String> param, CodeModel codeModel, Model model) {
		
    	//코드 디테일 삭제 
    	codeService.delCodeDetail(codeModel);
		
		//코드 마스터 삭제
		codeService.delCodeMaster(codeModel);
		
		//등록 완료 플레그 
    	model.addAttribute("result", "1");
    	
    	return "jsonView";
    }
}
