package com.sicc.admin.demo.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.sicc.admin.demo.service.impl.CustomUserDetailsService;

import javax.annotation.Resource;

@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Resource
	CustomUserDetailsService detailsService;
	
	@Override
	public void configure(WebSecurity web) throws Exception
	{
		web.ignoring().antMatchers("/css/**", "/script/**", "image/**", "/fonts/**", "lib/**");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception
	{
		http.csrf().disable().authorizeRequests()
		.antMatchers("/**").hasRole("ADMIN")
		.antMatchers("/**").permitAll()
		.and().formLogin()
		.loginPage("/login")
		.loginProcessingUrl("/login")
		.defaultSuccessUrl("/test")
    	.failureUrl("/login")
    	.and()
    	.logout();
		
		
		//http.csrf().disable().authorizeRequests().antMatchers("/regUser", "regUserPage").permitAll()
		// To do : role 정의 및 접근 경로 변경
			//.antMatchers("/admin/**").hasRole("ADMIN")
		//.antMatchers("/**").hasRole("ADMIN")
			//.antMatchers("/**").permitAll();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(detailsService)
				.passwordEncoder(passwordEncoder());
	}
 
}