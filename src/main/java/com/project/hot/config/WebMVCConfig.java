package com.project.hot.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

@Configuration
public class WebMVCConfig implements WebMvcConfigurer{

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("index");
		registry.addViewController("/hottalk").setViewName("hotTalk/hottalk");
	}

	@Bean
	HandlerExceptionResolver hadleException() {
		SimpleMappingExceptionResolver smer = new SimpleMappingExceptionResolver();
		Properties mappingException = new Properties();
		mappingException.setProperty("BadAuthenticationException", "common/error/authentication");
		smer.setExceptionMappings(mappingException);
		smer.setDefaultErrorView("common/error/defaultErrorpage");
		return smer;
	}
}
