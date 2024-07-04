package com.project.hot.employee.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.hot.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/employee")
public class EmployeeRestController {

	private final EmployeeService service;

	@GetMapping("/selectEmployees")
	public Map<String, Object> getEmployees() {
		Map<String, Object> param=new HashMap<>();
		param.put("cPage", 1);
		return service.selectEmployees(param);
	}
}
