package com.project.hot.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.SearchEmployeeData;
import com.project.hot.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class EmployeeRestController {

	private final EmployeeService service;

	@GetMapping("/employeeList")
	public Map<String, Object> getEmployeeList(
			@RequestParam(defaultValue = "1") int cPage, 
			@RequestParam(defaultValue = "12") int numPerpage,
			@ModelAttribute SearchEmployeeData sd) {
		Map<String, Object> param=new HashMap<>();
		if(sd.getTitle()!=null) {
			param.put("title", sd.getTitle().equals("부서선택")?"":sd.getTitle());
		}
		param.put("name", sd.getName()==null?"":sd.getName());
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		return service.selectEmployeeList(param);
	}

	@GetMapping("/departmentList")
	public List<Department> selectDepartmentList(){
		return service.selectDepartmentList();
	}
}
