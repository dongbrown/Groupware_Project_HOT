package com.project.hot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMVCConfig implements WebMvcConfigurer{

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
		registry.addViewController("/hottalk").setViewName("hotTalk/hottalk");
		registry.addViewController("/loginpage").setViewName("common/loginpage");
		registry.addViewController("/addressbook").setViewName("employee/addressbook");
	}

//	@Bean
//	HandlerExceptionResolver hadleException() {
//		SimpleMappingExceptionResolver smer = new SimpleMappingExceptionResolver();
//		Properties mappingException = new Properties();
//		mappingException.setProperty("BadAuthenticationException", "common/error/authentication");
//		smer.setExceptionMappings(mappingException);
//		smer.setDefaultErrorView("common/error/defaultErrorpage");
//		return smer;
//	}
}
