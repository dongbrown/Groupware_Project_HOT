package com.project.hot.project.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.service.ProjectService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/project")
@RequiredArgsConstructor
public class ProjectController {

	private final ProjectService service;

	@GetMapping("/projectupdate.do")
	public String projectUpdate () {
//		m.addAttribute("projectNo",projectNo);
		return "project/projectUpdate";
	};

	@GetMapping("/projectinsert.do")
	public String projectInsert () {
		return "project/projectInsert";
	};

	@ResponseBody
	@GetMapping("/selectEmpByDept.do")
	public List<Employee> selectEmpByDept(@RequestParam("dept") String deptCode) {
	    List<Employee> result = service.selectEmpByDept(Integer.parseInt(deptCode));
	    return result;
	}
}
