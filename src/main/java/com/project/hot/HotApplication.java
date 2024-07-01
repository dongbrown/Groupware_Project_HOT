package com.project.hot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import com.project.hot.config.HotBanner;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class HotApplication {

	public static void main(String[] args) {
		//SpringApplication.run(HotApplication.class, args);

		SpringApplication app=new SpringApplication(HotApplication.class);
		app.setWebApplicationType(WebApplicationType.SERVLET);
		app.setBanner(new HotBanner());
		app.run(args);
	}

}
