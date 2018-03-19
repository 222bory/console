package com.sicc.console.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.MonitorModel;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.MonitorService;

@Controller
public class MonitorController {

    //private final Logger logger = LoggerFactory.getLogger(MonitorController.class);
    @Autowired
    CommonService commonService;
    
    @Autowired
    MonitorService monitorService;
    
   
    @GetMapping("/insMonitorForm")
    public String insertMonitorForm(Model model, @RequestParam(value="searchType", required=false) String searchType, @RequestParam(value="searchValue", required=false) String searchValue) {
    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<ContractExtModel> contractList = commonService.searchContract(searchType, searchValue);
    	List<CodeModel> cpScaleCdList = commonService.selCode(CommonEnums.CP_SCALE_CD.getValue());
    	List<CodeModel> cpTypeCdList = commonService.selCode(CommonEnums.CP_TYPE_CD.getValue());
    	
    	model.addAttribute("contractList", contractList);
    	model.addAttribute("cpScaleCdList", cpScaleCdList);
    	model.addAttribute("cpTypeCdList", cpTypeCdList);
    	
        return "/monitor/insMonitor";
    }
    
    @RequestMapping(value="/insMonitor",method=RequestMethod.POST)
    @Transactional(rollbackFor=Exception.class)
    public String insContract(Model model,MonitorModel monitorModel ,HttpServletRequest req, HttpServletResponse res) throws Exception {
    	String tenantId = req.getParameter("tenantId");
    	String [] montrnUrlAddr = req.getParameterValues("montrnUrlAddr");
        
    	//로그인정보 
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	monitorModel.setTenantId(tenantId);
    	monitorModel.setCrtId(userId);
    	monitorModel.setCrtIp(req.getRemoteAddr());
    	monitorModel.setUdtId(userId);
    	monitorModel.setUdtIp(req.getRemoteAddr());
    	
    	for(int i=0; i<montrnUrlAddr.length;i++) {
    		if(i == 0) {
    			monitorModel.setMontrnFgCd("SERVICE");
    		}else {
    			monitorModel.setMontrnFgCd("FLOW");
    		}
    		monitorModel.setMontrnUrlAddr(montrnUrlAddr[i]);
    	
    		//모니터링 URL 등록
    		monitorService.insMonitor(monitorModel);
    	}
        	//등록 완료 플레그 
        	model.addAttribute("result", "1");
        	
    	return "jsonView";
    	
    }
    
    @RequestMapping("/selListMonitor")
    public String selListMonitor(@RequestParam Map<String, String> param, MonitorModel monitorModel, Model model) {
		// 페이징 처리
//		String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
//		if(NumberUtils.toInt(page) < 1) page = "1";
//		
//		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
//		
//		contractExtModel.setRowPerPage(rows);
//		contractExtModel.setPage(NumberUtils.toInt(page));
//		contractExtModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
    	
		
        List<MonitorModel> list = monitorService.selListMonitor(monitorModel);  
        
        //페이징 처리
//        Pagination pagination = new Pagination();
//		if(list != null && !list.isEmpty() ){
//			pagination.setTotalRow(list.get(0).getTotalCount()).setRowPerPage(rows).setCurrentPage(page);
//		} else {
//			pagination.setTotalRow(0);
//		}
//		
//		System.out.println("addate : "+list.get(0).getAdDate());
		
		model.addAttribute("list", list);
        model.addAttribute("monitorModel", monitorModel); 
//		model.addAttribute("pagination", pagination);
    	
    	return "/monitor/selListMonitor";
    	
    }
    
    @RequestMapping("/selMonitorView")
    public String selMonitorView(@RequestParam Map<String, String> param, MonitorModel monitorModel, Model model) {
		System.out.println(param.get("tenantId"));
    	
    	MonitorModel mm = monitorService.selMonitor(monitorModel);  
        
		
		model.addAttribute("mm", mm); 
       return "/monitor/selMonitor";
    	
    }
    
    @RequestMapping("/delMonitor")
    public String delMonitor(@RequestParam Map<String, String> param, MonitorModel monitorModel, Model model) {
		
    	System.out.println(">>>>>>>>>>>>>>>>>>>>>> tenantId : "+monitorModel.getTenantId());
		//모니터 삭제
    	monitorService.delMonitor(monitorModel);
		System.out.println("계약 삭제 완료!");
		
		//등록 완료 플레그 
    	model.addAttribute("result", "1");
    	
    	return "jsonView";
    }
    
    @RequestMapping("/upMonitorForm")
    public String upMonitorForm(Model model, @RequestParam(value="searchType", required=false) String searchType, @RequestParam(value="searchValue", required=false) String searchValue, MonitorModel monitorModel) {
    	if(searchType == null) {
    		searchType = "C";
    	}
    	
    	List<ContractExtModel> contractList = commonService.searchContract(searchType, searchValue);
    	List<CodeModel> cpScaleCdList = commonService.selCode(CommonEnums.CP_SCALE_CD.getValue());
    	List<CodeModel> cpTypeCdList = commonService.selCode(CommonEnums.CP_TYPE_CD.getValue());
				
		MonitorModel mm = monitorService.selMonitor(monitorModel);  
        
		model.addAttribute("contractList", contractList);
    	model.addAttribute("cpScaleCdList", cpScaleCdList);
    	model.addAttribute("cpTypeCdList", cpTypeCdList);
		model.addAttribute("mm", mm); 
       return "/monitor/upMonitor";
    	
    }
    
    @RequestMapping("/upMonitor")
    public String upMonitor(@RequestParam Map<String, String> param, MonitorModel monitorModel, Model model,HttpServletRequest req, HttpServletResponse res) {
		
		//contractExtModel.getCustId();
		//contractExtModel.getTenantId();
		System.out.println("map : "+param.toString());
		
		//모니터 URL 업데이트
		String tenantId = req.getParameter("tenantId");
    	String [] montrnUrlAddr = req.getParameterValues("montrnUrlAddr");
        
    	System.out.println(">>>>>>>>>>>>>>>>>>>>>> tenantId : "+ tenantId);
    	//로그인정보 
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String userId = principal.getUsername();
    	
    	monitorModel.setTenantId(tenantId);
    	monitorModel.setCrtId(userId);
    	monitorModel.setCrtIp(req.getRemoteAddr());
    	monitorModel.setUdtId(userId);
    	monitorModel.setUdtIp(req.getRemoteAddr());
    	
    	for(int i=0; i<montrnUrlAddr.length;i++) {
    		if(i == 0) {
    			monitorModel.setMontrnFgCd("SERVICE");
    		}else {
    			monitorModel.setMontrnFgCd("FLOW");
    		}
    		monitorModel.setMontrnUrlAddr(montrnUrlAddr[i]);
    	
    		//모니터링 URL 수정
    		monitorService.upMonitor(monitorModel);
    	}
		
		
		model.addAttribute("result", "1");
    	
    	return "jsonView";
    }
}
