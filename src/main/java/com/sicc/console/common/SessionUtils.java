package com.sicc.console.common;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Component;

import java.util.List;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;

@Component
public class SessionUtils implements ApplicationListener<SessionDestroyedEvent>, HttpSessionListener{
	
    @Autowired
    private SessionRegistry sessionRegistry;
    
    public void expireUserSessions(String username) {
    	
        for (Object principal : sessionRegistry.getAllPrincipals()) {
            if (principal instanceof User) {
                UserDetails userDetails = (UserDetails) principal;
                
                if (userDetails.getUsername().equals(username)) {
                    for (SessionInformation information : sessionRegistry.getAllSessions(userDetails, true)) {
                        information.expireNow();
                    }
                }
            }
        }
    }

    @Override
    public void onApplicationEvent(SessionDestroyedEvent event){
    	
        List<SecurityContext> lstSecurityContext = event.getSecurityContexts();
        UserDetails ud;
        for (SecurityContext securityContext : lstSecurityContext){
            ud = (UserDetails) securityContext.getAuthentication().getPrincipal();
            
            expireUserSessions(ud.getUsername());
        }
    }

	@Override
	public void sessionCreated(HttpSessionEvent se) {
        se.getSession().setMaxInactiveInterval(60*60);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		se.getSession().invalidate();
	}
    
    
}