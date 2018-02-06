package com.sicc.console.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils; 
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
import org.springframework.web.bind.annotation.RestController;

import com.sicc.console.common.Pagination;
import com.sicc.console.enums.CommonEnums;
import com.sicc.console.model.CodeModel;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.model.ContractModel;
import com.sicc.console.model.CustomerModel;
import com.sicc.console.service.CommonService;
import com.sicc.console.service.ContractService; 

@Controller
public class ContractController { 

    //private final Logger logger = LoggerFactory.getLogger(ContController.class);
	private Integer rowPerPage = 10;  
	
    @Autowired
    ContractService contractService;
    
    @Autowired
    CommonService commonService;

    @GetMapping("/insContract") 
    public String insContract(Model model) {
    	String tid = commonService.selTenantIdSeq();
    	//코드 조회
    	List<CodeModel> contStatCdList = commonService.selCode(CommonEnums.CONT_STAT_CD.getValue());
    	List<CodeModel> networkFgCdList = commonService.selCode(CommonEnums.NETWORK_FG_CD.getValue());
    	List<CodeModel> passwordLodCdList = commonService.selCode(CommonEnums.PASSWORD_LOD_CD.getValue());
    	List<CodeModel> rnwlCyclCd = commonService.selCode(CommonEnums.RNWL_CYCL_CD.getValue());
    	
    	model.addAttribute("contStatCdList", contStatCdList);         //계약상태코드
    	model.addAttribute("networkFgCdList", networkFgCdList);		  //네트워크구분코드
    	model.addAttribute("passwordLodCdList", passwordLodCdList);	  //비밀번호난이도코드
    	model.addAttribute("rnwlCyclCd", rnwlCyclCd);				  //비밀번호갱신주기코드
    	model.addAttribute("tid", tid);
    	
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
    public String insContract(Model model ,ContractExtModel contractExtModel,
    		@RequestParam(value="custId", required=true) String custId, 
    		@RequestParam("custNm") String custNm, 
    		@RequestParam("repFaxNo") String repFaxNo,
    		@RequestParam("repTelNo") String repTelNo,
    		@RequestParam("corpAdNo") String corpAdNo,
    		@RequestParam("mgrNm") String mgrNm,
    		@RequestParam("mgrEmailAddr") String mgrEmailAddr,
    		@RequestParam("mgrTelNo") String mgrTelNo,
    		@RequestParam("tenantId") String tenantId,
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
    		HttpServletRequest req, HttpServletResponse res) throws Exception {
		
    	
    		//유효일 처리
        	validStartDt = validStartDt.replaceAll("-", "");
        	validEndDt = validEndDt.replaceAll("-", "");
        	
        	System.out.println(custId+" "+custNm+" "+repFaxNo+" "+repTelNo +" "+corpAdNo +" "+mgrNm +" "+mgrEmailAddr +" "+mgrTelNo +" "+contNm +" "+
        			validStartDt+" "+ validEndDt+" "+contStatCd+" "+ networkFgCd+" "+ passwordLodCd +" "+passwordMinLen+" "+ passwordRnwlCyclCd +" "+passwordUseLmtYn+" "+ passwordPoseYn
        			);
        	
        	//고객 정보 체크 
        	contractExtModel.setCustId(custId);
        	List<ContractExtModel> list = contractService.selListContractCnt(contractExtModel);
        	System.out.println("list.size : " + list.size());
        	
        	//로그인정보 
        	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        	String userId = principal.getUsername();
        	
        	//계약 등록
        	ContractModel contractModel = new ContractModel();
        	
        	if(list.size() <1) {
    	    	CustomerModel customerModel = new CustomerModel();
    	    	customerModel.setCustId(custId);
    	    	customerModel.setCustNm(custNm);
    	    	customerModel.setRepFaxNo(repFaxNo);
    	    	customerModel.setRepTelNo(repTelNo);
    	    	customerModel.setCorpAdNo(corpAdNo);
    	    	customerModel.setMgrNm(mgrNm);
    	    	customerModel.setMgrEmailAddr(mgrEmailAddr);
    	    	customerModel.setMgrTelNo(mgrTelNo);
    	    	customerModel.setCrtId(userId);
    	    	customerModel.setCrtIp(req.getRemoteAddr());
    	    	customerModel.setUdtId(userId);
    	    	customerModel.setUdtIp(req.getRemoteAddr());
    	    	//고객정보 등록
    	    	contractService.insCustomer(customerModel);
        	}
        	
        	contractModel.setTenantId(tenantId);
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
        	contractModel.setCrtId(userId);
        	contractModel.setCrtIp(req.getRemoteAddr());
        	contractModel.setUdtId(userId);
        	contractModel.setUdtIp(req.getRemoteAddr());
        	//계약정보등록
        	contractService.insContract(contractModel);
        	
        	//등록 완료 플레그 
        	model.addAttribute("result", "1");
        	
    	return "jsonView";
    	
    }
    

}