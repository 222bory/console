package com.sicc.console.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sicc.console.common.Pagination;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ContractModel;
import com.sicc.console.model.CustomerModel;
import com.sicc.console.service.ContractService; 

@Controller
public class ContractController { 

    //private final Logger logger = LoggerFactory.getLogger(ContController.class);
	private Integer rowPerPage = 10;  
	
    @Autowired
    ContractService contractService;
    

    @GetMapping("/insContract") 
    public String insContract() {
        return "/contract/insContract";
    }
    
	@RequestMapping("/selListContract")
    public String selectListContract(@RequestParam Map<String, String> param, ContractExtModel contractExtModel, Model model) {
		// 페이징 처리
		String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
		contractExtModel.setRowPerPage(rows);
		contractExtModel.setPage(NumberUtils.toInt(page));
		contractExtModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
    	
		
        List<ContractExtModel> list = contractService.selListContract(contractExtModel);  
        
        System.out.println("list : "+ list.get(0));
        //페이징 처리
        Pagination pagination = new Pagination();
		if(list != null && !list.isEmpty() ){
			pagination.setTotalRow(list.get(0).getTotalCount()).setRowPerPage(rows).setCurrentPage(page);
		} else {
			pagination.setTotalRow(0);
		}
		
		System.out.println("addate : "+list.get(0).getAdDate());
		
		model.addAttribute("list", list);
        model.addAttribute("adminModel", contractExtModel); 
		model.addAttribute("pagination", pagination);
    	
    	return "/contract/selListContract";
    	
    }
	
    @PostMapping("/insContract")
    @Transactional(rollbackFor=Exception.class)
    public String insContract(Model model , 
    		@RequestParam(value="custId", required=true) String custId, 
    		@RequestParam("custNm") String custNm, 
    		@RequestParam("repFaxNo") String repFaxNo,
    		@RequestParam("repTelNo") String repTelNo,
    		@RequestParam("corpAdNo") String corpAdNo,
    		@RequestParam("mgrNm") String mgrNm,
    		@RequestParam("mgrEmailAddr") String mgrEmailAddr,
    		@RequestParam("mgrTelNo") String mgrTelNo,
    		@RequestParam("contNm") String contNm,
    		@RequestParam("validStartDt") String validStartDt,
    		@RequestParam("validEndDt") String validEndDt,
    		@RequestParam("contStatCd") String contStatCd,
    		@RequestParam("networkFgCd") String networkFgCd,
    		@RequestParam("passwordLodCd") String passwordLodCd,
    		@RequestParam("passwordMinLen") String passwordMinLen,
    		@RequestParam("passwordRnwlCyclCd") String passwordRnwlCyclCd,
    		@RequestParam("passwordUseLmtYn") String passwordUseLmtYn,
    		@RequestParam("passwordPoseYn") String passwordPoseYn,
    		HttpServletRequest req, HttpServletResponse res) {
		
    	
    	System.out.println(custId+" "+custNm+" "+repFaxNo+" "+repTelNo +" "+corpAdNo +" "+mgrNm +" "+mgrEmailAddr +" "+mgrTelNo +" "+contNm +" "+
    			validStartDt+" "+ validEndDt+" "+contStatCd+" "+ networkFgCd+" "+ passwordLodCd +" "+passwordMinLen+" "+ passwordRnwlCyclCd +" "+passwordUseLmtYn+" "+ passwordPoseYn
    			);
    	
    	CustomerModel customerModel = new CustomerModel();
    	ContractModel contractModel = new ContractModel();
    	
    	customerModel.setCustId(custId+System.currentTimeMillis());
    	customerModel.setCustNm(custNm);
    	customerModel.setRepFaxNo(repFaxNo);
    	customerModel.setRepTelNo(repTelNo);
    	customerModel.setCorpAdNo(corpAdNo);
    	customerModel.setMgrNm(mgrNm);
    	customerModel.setMgrEmailAddr(mgrEmailAddr);
    	customerModel.setMgrTelNo(mgrTelNo);
    	customerModel.setCrtId("test");
    	customerModel.setCrtIp(req.getRemoteAddr());
    	customerModel.setUdtId("test");
    	customerModel.setUdtIp(req.getRemoteAddr());
    	
    	contractService.insCustomer(customerModel);
    	
    	contractModel.setTenantId("t"+System.currentTimeMillis());
    	contractModel.setCustId(custId);
    	contractModel.setContNm(contNm);
    	contractModel.setValidStartDt(validStartDt);
    	contractModel.setValidEndDt(validEndDt);
    	contractModel.setContStatCd(contStatCd);
    	contractModel.setNetworkFgCd(networkFgCd);
    	contractModel.setPasswordLodCd(passwordLodCd);
    	contractModel.setPasswordMinLen(Integer.parseInt(passwordMinLen));
    	contractModel.setPasswordRnwlCyclCd(passwordRnwlCyclCd);
    	contractModel.setPasswordUseLmtYn(passwordUseLmtYn);
    	contractModel.setPasswordPoseYn(passwordPoseYn);
    	contractModel.setCrtId("test");
    	contractModel.setCrtIp(req.getRemoteAddr());
    	contractModel.setUdtId("test");
    	contractModel.setUdtIp(req.getRemoteAddr());
    	
    	contractService.insContract(contractModel);
    	
    	return "/contract/insContract";
    	
    }
    

}