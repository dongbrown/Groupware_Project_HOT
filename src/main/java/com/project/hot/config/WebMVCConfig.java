package com.project.hot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.project.hot.common.converter.StringToSqlDateConverter;

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
		registry.addViewController("/project/projectListAll.do").setViewName("project/projectListAll");
		registry.addViewController("/employee/commuting").setViewName("employee/commuting");
		registry.addViewController("/employee/vacation").setViewName("employee/vacation");
		registry.addViewController("/employee/profile").setViewName("employee/profile");
		registry.addViewController("/hr/orgChart").setViewName("humanResource/orgChart");
		registry.addViewController("/hr/department").setViewName("humanResource/department");
		registry.addViewController("/hr/employee").setViewName("humanResource/employee");
		registry.addViewController("/hr/createEmployee").setViewName("humanResource/createEmployee");
		registry.addViewController("/hr/allEmpCommuting").setViewName("humanResource/allEmpCommuting");
		registry.addViewController("/approval/approvalAllList").setViewName("approval/approvalAllList");
	}

	@Override
	public void addFormatters(FormatterRegistry registry) {
		registry.addConverter(new StringToSqlDateConverter());
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
