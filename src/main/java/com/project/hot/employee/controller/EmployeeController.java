package com.project.hot.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/employee")
public class EmployeeController {

	private final EmployeeService service;

	/*
	 * @GetMapping("/addressbook.do") public String
	 * addressBook(@RequestParam(defaultValue = "1") int cPage, Model m) {
	 * Map<String, Object> param=new HashMap<>(); param.put("cPage", cPage);
	 * param.put("numPerpage", 12); Map<String, Object>
	 * result=service.selectEmployeeList(param); m.addAttribute("employees",
	 * (List<Employee>)result.get("employees")); m.addAttribute("departments",
	 * (List<Department>)result.get("departments")); return "employee/addressbook";
	 * }
	 */
}
