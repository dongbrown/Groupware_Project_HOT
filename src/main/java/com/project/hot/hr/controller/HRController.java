package com.project.hot.hr.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.hot.hr.model.service.HRService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/hr")
public class HRController {

	private final HRService service;

	@GetMapping("/departmentList")
	public Map<String, Object> selectDepartmentForHR(
			@RequestParam(defaultValue="1")int cPage
			, @RequestParam(defaultValue="") String departmentTitle){
		Map<String, Object> param=new HashMap<>();
		param.put("cPage", cPage);
		param.put("numPerpage", 10);
		param.put("departmentTitle", departmentTitle.equals("부서전체")?"":departmentTitle);
		Map<String, Object> result=service.selectDepartmentListForHR(param);
		return result;
	}

	@PostMapping("/insertDepartment")
	public String insertDepartment() {

		return "";
	}
}
