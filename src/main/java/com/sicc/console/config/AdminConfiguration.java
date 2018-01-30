package com.sicc.admin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import com.sicc.admin.dao.AdminDao;
import com.sicc.admin.dao.CommonDao;
import com.sicc.admin.dao.impl.AdminDaoImpl;

@Configuration
public class AdminConfiguration {
  
  @Bean
  public TilesConfigurer tilesConfigurer() {
	  final TilesConfigurer configurer = new TilesConfigurer();
	  configurer.setDefinitions(new String[] {"WEB-INF/tiles/tiles.xml"});
	  configurer.setCheckRefresh(true);
	  return configurer;
  }
  
  @Bean
  public TilesViewResolver tilesViewResolver() {
	  final TilesViewResolver resolver = new TilesViewResolver();
	  resolver.setViewClass(TilesView.class);
	  return resolver;
  }
  
  @Bean
  public AdminDao adminDao() {
	return new AdminDaoImpl();
  }

}