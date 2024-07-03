package com.project.hot.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.hot.common.PageFactory;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/employee")
public class EmployeeController {

	private final EmployeeService service;
	private final PageFactory page;
	
	@GetMapping("/addressbook.do")
	public String addressBook(@RequestParam(defaultValue = "1") int cPage, @RequestParam(defaultValue = "5") int numPerpage, Model m) {
		Map<String, Object> param=new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		Map<String, Object> result=service.selectEmployees(param);
		m.addAttribute("employees", (List<Employee>)result.get("employees"));
		m.addAttribute("pagebar", page.getpage(cPage, numPerpage, (int)result.get("totalData"), "addressbook.do"));
		return "employee/addressbook";
	}
}
