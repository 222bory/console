package com.sicc.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sicc.admin.model.Member;
import com.sicc.admin.service.UserService;
import com.sicc.admin.service.impl.CustomUserDetailsService;

@Controller
public class MonitorController {

    private final Logger logger = LoggerFactory.getLogger(IndexController.class);
    UserService userService;
    CustomUserDetailsService customUserDetailsService;
    
    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/insMonitorForm")
    public String insertMonitorForm() {
    	System.out.println("모니터링 고고!!");
        return "/monitor/insMonitor";
    }
    
    /*@RequestMapping(value="/insMonitor",method=RequestMethod.POST)
    public String insertMonitor(Model model , HttpServletRequest req, HttpServletResponse res) {
    	System.out.println("submit!!");
    	String hUrl = (String) req.getAttribute("hystricx");
    	String zUrl	= (String) req.getAttribute("zipkin");
    	System.out.println("hystrix : "+hUrl);
    	System.out.println("zipkin : "+zUrl);
    	
    	
        return "";
    }*/
    
    @RequestMapping(value="/insMonitor",method=RequestMethod.POST)
    public String insertMonitor(Model model , HttpServletRequest req, HttpServletResponse res) {
    	System.out.println("submit!!");
    	String hUrl = (String) req.getParameter("hystricx");
    	String zUrl	= (String) req.getParameter("zipkin");
    
    	System.out.println("hystrix1 : "+hUrl);
    	System.out.println("zipkin1 : "+zUrl);
    	
    	
        return "";
    }
    
/*    @PostMapping("/login")
    public String login(Model model , @RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest req, HttpServletResponse res) {
		
    	System.out.println("test" + username);
    	customUserDetailsService.loadUserByUsername(username);
    	
    	return "/admin/admin";
    	
    }*/
    
/*    @GetMapping("/test")
    public String admin(Model model) {
    	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	Member member = userService.findByUserNameOrEmail(principal.getUsername());
    	
    	System.out.println(member.getId());
    	System.out.println(member.getUid());
    	System.out.println(member.getUemail());
    	
    	model.addAttribute("member", member);
    	model.addAttribute("roles", member.getRoles());
    	
        return "/admin/test";
    }*/
    
/*    @GetMapping("/regUser")
    public String regUserPage() {
    	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	
    	System.out.println(principal.getUsername());
    	System.out.println(principal.getPassword());
    	
    	Iterator it = principal.getAuthorities().iterator();
    	
    	while(it.hasNext()) {
    		GrantedAuthority g = (GrantedAuthority) it.next();
    		System.out.println(g.getAuthority());
    	}
    	
    	return "/regUser/regUser";
    	
    }*/
    
//    @PostMapping("/regUser")
//    public String regUser(Model model , @RequestParam("id") String id, @RequestParam("upw") String upw,
//    		@RequestParam("uemail") String uemail, HttpServletRequest req, HttpServletResponse res) {
//		
//    	System.out.println("test : " + id + " "+upw + " "+uemail);
//    	
//    	Member member = new Member();
//		
//		member.setId(id);
//		member.setUid(id+"1");
//		member.setUpw(upw);
//		member.setUemail(uemail);
//		
//    	userService.createMember(member);
//    	
//    	return "/login/login";
//    	
//    }

}
