package com.sicc.console.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sicc.console.service.UserService;
import com.sicc.console.service.impl.CustomUserDetailsService;

@Controller
public class IndexController { 

    private final Logger logger = LoggerFactory.getLogger(IndexController.class);
    UserService userService;
    CustomUserDetailsService customUserDetailsService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /*@GetMapping("/login")
    public String index() {
        return "/login/login";
    }*/
    
    @GetMapping("/login") 
    public String index() {
    	//로그인시 세션 초기화 
    	SecurityContextHolder.getContext().setAuthentication(null);
        return "login";
    }
    
    @PostMapping("/login")
    public String login(Model model , @RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest req, HttpServletResponse res) {
		
    	System.out.println("test" + username);
    	customUserDetailsService.loadUserByUsername(username);
    	
    	return "/admin/admin";
    	
    }
    
  /*  @GetMapping("/test")
    public String admin(Model model) {
    	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	List<Member> memberList = userService.getMember();
    	
    	
    	model.addAttribute("memberList", memberList);
    	
        return "/admin/test";
    }*/
    
    

}