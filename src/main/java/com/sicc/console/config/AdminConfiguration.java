package com.sicc.console.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import com.sicc.console.dao.AdminDao;
import com.sicc.console.dao.CodeDao;
import com.sicc.console.dao.CompetitionDao;
import com.sicc.console.dao.ContractDao;
import com.sicc.console.dao.CustomerDao;
import com.sicc.console.dao.ServiceApplyDao;
import com.sicc.console.dao.impl.AdminDaoImpl;
import com.sicc.console.dao.impl.CodeDaoImpl;
import com.sicc.console.dao.impl.CompetitionDaoImpl;
import com.sicc.console.dao.impl.ContractDaoImpl;
import com.sicc.console.dao.impl.CustomerDaoImpl;
import com.sicc.console.dao.impl.ServiceApplyDaoImpl; 

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
  public CodeDao codeDao() {
	return new CodeDaoImpl(); 
  }
  
  @Bean
  public AdminDao adminDao() {
	return new AdminDaoImpl();
  }
  
  @Bean
  public CustomerDao customerDao() {
	return new CustomerDaoImpl();
  }
  
  @Bean
  public ContractDao contractDao() {
	return new ContractDaoImpl();
  }
  
  @Bean
  public CompetitionDao competitionDao() {
	return new CompetitionDaoImpl();
  }
  
  @Bean
  public ServiceApplyDao serviceApplyDao() {
	return new ServiceApplyDaoImpl();
  }

}