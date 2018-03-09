package com.sicc.console.controller;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sicc.console.common.ExportDataToFile;
import com.sicc.console.model.ContractExtModel;
import com.sicc.console.service.ContractService;
import com.sicc.console.service.FileDownService;

@Controller
public class FileController {

	@Autowired 
	FileDownService fileDownService;
	
	@Autowired 
	ContractService contractService;
	
	@GetMapping("/fileDownload")
    public String fildDownload(Model model) {

    	List<String> tenantList = fileDownService.selTenantList();
    	
    	model.addAttribute("tenantList",tenantList);

    	return "/file/fileDownload";
    }

    
    @ResponseBody
    @PostMapping("/exportQuery")
    public String exportQuery (HttpServletRequest req, 
			HttpServletResponse res,
			@RequestParam("tenantId") String tenantId) {
    	
    	ContractExtModel contractExtModel = new ContractExtModel();
    	contractExtModel.setTenantId(tenantId);
    	
    	ContractExtModel contractList = contractService.selContract(contractExtModel);

    	
        Map map = new HashMap();

        map.put("tenant_id", contractList.getTenantId());
        map.put("cust_id", contractList.getCustId());
        map.put("cont_nm", contractList.getContNm());
        map.put("valid_start_dt", contractList.getValidStartDt());
        map.put("valid_end_dt", contractList.getValidEndDt());
        map.put("cont_stat_cd", contractList.getContStatCd());
        map.put("network_fg_cd", contractList.getNetworkFgCd());
        map.put("password_lod_cd", contractList.getPasswordLodCd());
        map.put("password_min_len", contractList.getPasswordMinLen());
        map.put("password_rnwl_cycl_cd", contractList.getPasswordRnwlCyclCd());
        map.put("password_use_lmt_yn", contractList.getPasswordUseLmtYn());
        map.put("password_pose_yn", contractList.getPasswordPoseYn());
        map.put("crt_id", contractList.getCrtId());
        map.put("crt_ip", contractList.getCrtIp());
        map.put("ad_date", contractList.getAdDate());
        map.put("udt_id", contractList.getUdtId());
        map.put("udt_ip", contractList.getUdtIp());
        map.put("udt_date", contractList.getUdtDate());

        ExportDataToFile ef = new ExportDataToFile();
        
        String query = ef.getInsertQueryString(map, "concustcontm");

        System.out.println(query);
        
        return "1";
    	
    }
    

    
    @ResponseBody
    @PostMapping("/exportData")
    public String exportData(HttpServletRequest req, 
    					HttpServletResponse res,
    					@RequestParam("tenantId") String tenantId){
    	String result = "";
    	String fileName = "C:/download/["+tenantId+"]InsertQuery.sql";
    	BufferedWriter writer = null;

    	List<String> rowdata= fileDownService.selTenantIdByAllData(tenantId);

    	try {
    		writer = new BufferedWriter( new FileWriter(fileName));

	    	for(String m : rowdata) {
	    		writer.write(m);
	    		writer.newLine();
	    	}
	    	
	    	writer.close();
	    
	    	result = "1";
    	}
    	catch(IOException io) {
    		io.printStackTrace();
    	}
    	
    	
    	
    	
    	/*
    	 * String fileName = "myRowData.csv";
    	res.setContentType("text/csv");
        // creates mock data
        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"%s\"",fileName);
        res.setHeader(headerKey, headerValue);
        
        // uses the Super CSV API to generate CSV data from the model data
        ICsvBeanWriter csvWriter = new CsvBeanWriter(res.getWriter(),
                CsvPreference.EXCEL_PREFERENCE);
        String[] header = { "rowdata" };
        
        csvWriter.writeHeader(header);

    	for(String m : rowdata) {
    		csvWriter.write(m, header);
    	}
    	
    	csvWriter.close();
    	*/
    	
    	return result;
    }
	
	
	
	
}
