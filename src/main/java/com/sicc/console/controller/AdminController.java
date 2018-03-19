package com.sicc.console.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sicc.console.common.Pagination;
import com.sicc.console.model.AdminModel;
import com.sicc.console.model.Member;
import com.sicc.console.service.AdminService;

@Controller
public class AdminController {
	//private final Logger logger = LoggerFactory.getLogger(AdminController.class);
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
		
		model.addAttribute("list", list); 
        model.addAttribute("adminModel", adminModel);
		model.addAttribute("pagination", pagination);
    	
    	return "/admin/selectListAdmin";
    	
    }
	
	@GetMapping("/insAdminForm")
    public String insAdminForm() {
    	return "/admin/insAdmin";
    }
    
    @PostMapping("/insAdmin")
    public String insAdmin(Model model,
					HttpServletRequest req, 
					HttpServletResponse res,
		    		@RequestParam("id") String adminId, 
		    		@RequestParam("upw") String password,
		    		@RequestParam("uemail") String emailAddr,
		    		@RequestParam("radioRole") String adminPrivCd,
		    		@RequestParam("uname") String adminNm) {
 	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	String crtId = principal.getUsername(); //현재 사용자
    	String crtIp = req.getRemoteAddr(); //현재 사용자 ip
    	
    	AdminModel adminModel = new AdminModel();
		
    	adminModel.setAdminId(adminId);
    	adminModel.setPassword(password);
    	adminModel.setAdminNm(adminNm);
    	adminModel.setAdminPrivCd(adminPrivCd);
    	adminModel.setEmailAddr(emailAddr);
    	adminModel.setCrtId(crtId);
    	adminModel.setCrtIp(crtIp);
    	
    	try {
    		adminService.insAdmin(adminModel);
    	
    		model.addAttribute("result", "1");
    	}
    	catch(Exception e){
    		System.out.println(e.getMessage());
    	}
    	
    	return "jsonView";
    }
    
    @ResponseBody
    @PostMapping("/userDuplCheck")
    public String userDuplCheck(HttpServletRequest req, @RequestParam("userID") String userID) {
    	String result="";
    	 
    	Member member = adminService.findByUserNameOrEmail(userID);
    	
    	if(member==null) {
    		result="0";
    	}
    	else {
    		result="1";
    	}
    	
    	return result;
    }
    
    @PostMapping("/delAdmin")
    public String delAdmin(Model model,
    				HttpServletRequest req,
    				HttpServletResponse res,
    				@RequestParam(value="delId", required=true) String delId) {

    	try {
    		adminService.delAdmin(delId);
    	
    		model.addAttribute("result", "1");
    	}
    	catch(Exception e){
    		System.out.println(e.getMessage());
    	}
    	return "jsonView";
    }
    
}
