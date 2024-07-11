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

import com.fasterxml.jackson.core.JsonProcessingException;
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

	@ResponseBody
	@GetMapping("/projectupdateajax")
	public Map<String,Object> projectUpdatePage (@RequestParam(defaultValue = "1") int cPage) {
		ObjectMapper mapper=new ObjectMapper();
		try {
			mapper.writeValueAsString(service.selectProjectAll(Map.of("cPage",cPage,"numPerpage",5)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		System.out.println("ㅎㅁ~~");
		return service.selectProjectAll(Map.of("cPage",cPage,"numPerpage",5));
	};

	@GetMapping("/projectinsert.do")
	public String projectInsertPage (Department d,Model m) {
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("depts",depts);
		return "project/projectInsert";
	};

	@ResponseBody
	@GetMapping("/selectEmpByDept.do")
	public List<Employee> selectEmpByDept(@RequestParam("dept") int deptCode,
											@RequestParam("empNo") int empNo) {

	    List<Employee> result = service.selectEmpByDept(Map.of("deptCode",deptCode,"empNo",empNo));
	    return result;
	}

	@ResponseBody
	@PostMapping("/insertProject.do")
	public ResponseEntity<String> insertProject(@RequestBody Project projectData) {
		try {
			service.insertProject(projectData);
			return ResponseEntity.ok("프로젝트 등록 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 등록 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 등록 실패");
		}
	}

//	@ResponseBody
//	@GetMapping("/selectProjectByNo.do")
//	public Project selectProjectByNo(@RequestParam("projectNo") int projectNo) {
//		Project result = service.selectProjectByNo(projectNo);
//		return result;
//	}

	@GetMapping("/selectProjectByNo.do")
	public String selectProjectByNo(int projectNo,int empNo, Model m) {
		Project project = service.selectProjectByNo(projectNo);
		List<ProjectEmployee> emps = service.selectEmployeetByProjectNo(Map.of("projectNo",projectNo,"empNo",empNo));
		List<Department> depts = service.selectDeptAll();
		m.addAttribute("project",project);
		m.addAttribute("emps",emps);
		m.addAttribute("depts",depts);
		return "project/projectUpdateDetail";
	}

	@ResponseBody
	@GetMapping("/selectEmployeetByProjectNo.do")
	public List<ProjectEmployee> selectEmployeetByProjectNo(@RequestParam("projectNo") int projectNo){
		List<ProjectEmployee> result = service.selectEmployeetByProjectNo(Map.of("projectNo",projectNo,"empNo",1));
		return result;
	}

	@ResponseBody
	@PostMapping("/updateProject.do")
	public ResponseEntity<String> updateProject(@RequestBody Project projectData){
		try {
			service.updateProject(projectData);
			return ResponseEntity.ok("프로젝트 업데이트 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 등록 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 업데이트 실패");
		}
	}

	@ResponseBody
	@PostMapping("/deleteProject.do")
	public ResponseEntity<String> deleteProject(@RequestBody int projectNo){
		try {
			service.deleteProject(projectNo);
			return ResponseEntity.ok("프로젝트 삭제 성공");
		} catch (Exception e) {
			log.error("=========프로젝트 등록 중 오류 발생=========", e);
			return ResponseEntity.badRequest().body("프로젝트 삭제 실패");
		}
	}
}
