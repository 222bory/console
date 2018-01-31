package com.sicc.console.controller;

import java.util.List;
import java.util.Map;


import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.sicc.console.common.Pagination;
import com.sicc.console.model.AdminModel;
import com.sicc.console.service.AdminService;

@Controller
public class AdminController {
	private final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Autowired
	AdminService adminService;
    
	private Integer rowPerPage = 10;  
	
	@RequestMapping("/selectListAdmin")
    public String selectListAdmin(@RequestParam Map<String, String> param, AdminModel adminModel, Model model) {
		// 페이징 처리
		String page = StringUtils.defaultIfEmpty(param.get("page"), "1");
		if(NumberUtils.toInt(page) < 1) page = "1";
		
		int rows = StringUtils.isNotEmpty( param.get("rowPerPage"))? NumberUtils.toInt(param.get("rowPerPage")) : rowPerPage;
		
		adminModel.setRowPerPage(rows);
		adminModel.setPage(NumberUtils.toInt(page));
		adminModel.setSkipCount(rows * (NumberUtils.toInt(page) - 1));
    	
		
        List<AdminModel> list = adminService.selectListAdmin(adminModel);  
      
        //페이징 처리
        Pagination pagination = new Pagination();
		if(list != null && !list.isEmpty() ){
			pagination.setTotalRow(list.get(0).getTotalCount()).setRowPerPage(rows).setCurrentPage(page);
		} else {
			pagination.setTotalRow(0);
		}
		
		System.out.println("addate : "+list.get(0).getAdDate());
		
		model.addAttribute("list", list);
        model.addAttribute("adminModel", adminModel);
		model.addAttribute("pagination", pagination);
    	
    	return "/admin/selectListAdmin";
    	
    }

}
