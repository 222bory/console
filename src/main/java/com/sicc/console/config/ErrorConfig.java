package com.sicc.console.config;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

@Configuration
public class ErrorConfig {
 
  @Bean
  public EmbeddedServletContainerCustomizer containerCustomizer() {
    return new EmbeddedServletContainerCustomizer() {
 
      @Override
      public void customize(ConfigurableEmbeddedServletContainer container) {
        ErrorPage error403Page = new ErrorPage(HttpStatus.FORBIDDEN, "/error/403.html");
        ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "/error/404.html");
        ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/500.html");
 
        container.addErrorPages(error403Page, error404Page, error500Page);
      }


    };
  }
 
}
