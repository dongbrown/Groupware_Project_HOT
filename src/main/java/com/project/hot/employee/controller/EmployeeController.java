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

	@GetMapping("/addressbook")
	private String addressbookPage(@RequestParam(defaultValue = "")String name, Model m) {
		m.addAttribute("name", name);
		return "employee/addressbook";
	}
}
