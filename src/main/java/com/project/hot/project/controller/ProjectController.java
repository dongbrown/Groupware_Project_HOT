package com.project.hot.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;
import com.project.hot.project.model.service.ProjectService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/project")
@RequiredArgsConstructor
public class ProjectController {

	private final ProjectService service;
	private final ObjectMapper mapper;

	@GetMapping("/projectupdate.do")
	public String projectUpdatePage (Department d,Model m) {
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("depts",depts);
		return "project/projectUpdate";
	};

	@GetMapping("/projectinsert.do")
	public String projectInsertPage (Department d,Model m) {
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("depts",depts);
		return "project/projectInsert";
	};

	@ResponseBody
	@GetMapping("/selectEmpByDept.do")
	public List<Employee> selectEmpByDept(@RequestParam("dept") String deptCode) {
	    List<Employee> result = service.selectEmpByDept(Integer.parseInt(deptCode));
	    return result;
	}

	@ResponseBody
	@PostMapping("/insertProject.do")
	public ResponseEntity<?> insertProject(@RequestBody Map<String,Object> data) {
		try {
		        Project project = mapper.convertValue(data.get("project"), Project.class);
		        System.out.println(project);
		        List<ProjectEmployee> members = mapper.convertValue(data.get("member"),
                        				new TypeReference<List<ProjectEmployee>>(){});
		        return ResponseEntity.ok("프로젝트 등록 성공");
		}catch(Exception e) {
			log.error("=========프로젝트 등록 중 오류 발생=========", e);
            return ResponseEntity.badRequest().body("프로젝트 등록 실패");
		}

		    }
	}

