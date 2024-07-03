package com.project.hot.security.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.service.EmployeeService;

@Component
public class UserPasswordAuthenticationProvider implements AuthenticationProvider {

	private BCryptPasswordEncoder pwencoder=new BCryptPasswordEncoder();

	@Autowired
	private EmployeeService service;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String userId=authentication.getName();
		String password=(String)authentication.getCredentials();
		Employee loginEmployee=service.selectEmployeeById(userId);
		if(loginEmployee!=null && pwencoder.matches(password, loginEmployee.getPassword())) {
			//로그인 성공
			return new UsernamePasswordAuthenticationToken(loginEmployee, loginEmployee.getPassword(), loginEmployee.getAuthorities());
		}else {
			throw new BadCredentialsException("인증실패");
		}
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}

}
