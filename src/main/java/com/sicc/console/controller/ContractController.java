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

import com.sicc.console.model.ContractModel;
import com.sicc.console.model.CustomerModel;
import com.sicc.console.model.Member;
import com.sicc.console.service.ContractService;
import com.sicc.console.service.UserService;
import com.sicc.console.service.impl.CustomUserDetailsService;

@Controller
public class ContractController { 

    //private final Logger logger = LoggerFactory.getLogger(ContController.class);

    @Autowired
    ContractService contractService;
    

    @GetMapping("/insContract") 
    public String contReg() {
        return "/contract/insContract";
    }
    
    @PostMapping("/insContract")
    @Transactional(rollbackFor=Exception.class)
    public String contReg(Model model , 
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