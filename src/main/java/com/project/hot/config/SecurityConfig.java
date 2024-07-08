package com.project.hot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsUtils;

import com.project.hot.security.controller.UserPasswordAuthenticationProvider;
import com.project.hot.security.service.SecurityLoginProvider;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig {

	private final UserPasswordAuthenticationProvider provider;
	private final SecurityLoginProvider securityLoginProvider;

	@Bean
	SecurityFilterChain authenticationFilter(HttpSecurity http) throws Exception{

		return http
				.csrf(csrf->csrf.disable())
				.authorizeHttpRequests(request->request
						.requestMatchers(CorsUtils::isPreFlightRequest).permitAll()
						.requestMatchers("/loginpage", "/WEB-INF/views/**", "/css/**", "/demo/**", "/images/**", "/js/**", "/scss/**", "/vendor/**").permitAll()
						.requestMatchers("/**").authenticated()
						.anyRequest().authenticated()		//권한 상관없이 인증을 받으면 허용
				)
				.authenticationProvider(provider) //Provider구현체를 넣어 인증을 내가 만든것으로 받게 만든다
				.formLogin(form->form
						.loginProcessingUrl("/login")
//						.successForwardUrl("/") 로그인 할 시 특정한 로직이 필요할 때 사용
						.failureForwardUrl("/loginpage")
						.loginPage("/loginpage")
				)
				.logout(logout->logout
						.logoutUrl("/logout")
						.logoutSuccessUrl("/loginpage")
				)
				.exceptionHandling(exception->exception
						.accessDeniedHandler(null)
				)
				.rememberMe(rememberMe->rememberMe
						.key("lmfwqemgwejgjasdq")
						.userDetailsService(securityLoginProvider)
						.rememberMeParameter("remember-me")
						.tokenValiditySeconds(43200))
				.build();
	}
}
