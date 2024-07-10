package com.project.hot.employee.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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

	// 사원 정보를 담은 리스트 반환
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

	// 부서 전체 리스트 반환
	@GetMapping("/departmentList")
	public List<Department> selectDepartmentList(){
		return service.selectDepartmentList();
	}

	// 사원 한명 출퇴근 정보 반환
	@GetMapping("/commuting/{no}")
	public Map<String, Object> getCommutingList(
			@PathVariable(name = "no") int employeeNo,
			@RequestParam String month,
			@RequestParam(defaultValue = "1") int cPage){
		Map<String, Object> param=new HashMap<>();
		param.put("employeeNo", employeeNo);
		param.put("year", LocalDate.now().getYear());
		param.put("month", month);
		param.put("cPage", cPage);
		param.put("numPerpage", 10);
		return service.selectCommutingList(param);
	}

}
