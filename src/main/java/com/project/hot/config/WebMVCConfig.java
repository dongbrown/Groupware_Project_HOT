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
		registry.addViewController("/project/projectupdate.do").setViewName("project/projectUpdate");
		registry.addViewController("/work/workinsert.do").setViewName("project/workInsert");
		registry.addViewController("/work/workupdate.do").setViewName("project/workUpdate");
		registry.addViewController("/commuting").setViewName("employee/commuting");
		registry.addViewController("/vacation").setViewName("employee/vacation");
		registry.addViewController("/profile").setViewName("employee/profile");
		registry.addViewController("/department").setViewName("humanResource/department");
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
