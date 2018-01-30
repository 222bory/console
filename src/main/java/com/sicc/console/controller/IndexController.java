package com.sicc.console.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sicc.console.common.WithHist;
import com.sicc.console.model.Member;
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
        return "login";
    }
    
    @PostMapping("/login")
    public String login(Model model , @RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest req, HttpServletResponse res) {
		
    	System.out.println("test" + username);
    	customUserDetailsService.loadUserByUsername(username);
    	
    	return "/admin/admin";
    	
    }
    
    @GetMapping("/test")
    public String admin(Model model) {
    	
    	User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	List<Member> memberList = userService.getMember();
    	
    	
    	model.addAttribute("memberList", memberList);
    	
        return "/admin/test";
    }
    
    @GetMapping("/regUser")
    public String regUserPage() {
    	
    	/*User principal = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	
    	System.out.println(principal.getUsername());
    	System.out.println(principal.getPassword());
    	
    	Iterator it = principal.getAuthorities().iterator();
    	
    	while(it.hasNext()) {
    		GrantedAuthority g = (GrantedAuthority) it.next();
    		System.out.println(g.getAuthority());
    	}*/
    	
    	return "/regUser/regUser";
    	
    }
    
    @PostMapping("/regUser")
    public String regUser(Model model , HttpServletRequest req, HttpServletResponse res,
    		@RequestParam("id") String adminId, 
    		@RequestParam("upw") String password,
    		@RequestParam("uemail") String emailAddr,
    		@RequestParam("radioRole") String adminPrivCd,
    		@RequestParam("uname") String adminNm
    		) {
		
    	System.out.println("test : " + adminId + " "+password + " "+emailAddr+ " "+adminPrivCd);
    	
    	Member member = new Member();
		
		member.setAdminId(adminId);
		member.setPassword(password);
		member.setAdminNm(adminNm);
		member.setAdminPrivCd(adminPrivCd);
		member.setEmailAddr(emailAddr);
		
    	userService.createMember(member);
    	
    	return "/login/login";
    	
    }
    
    @ResponseBody
    @PostMapping("/userDuplCheck")
    public String userDuplCheck(HttpServletRequest req, @RequestParam("userID") String userID) {
    	String result="";
    	 
    	Member member = userService.findByUserNameOrEmail(userID);
    	
    	if(member==null) {
    		result="0";
    	}
    	else {
    		result="1";
    	}
    	
    	return result;
    }

}