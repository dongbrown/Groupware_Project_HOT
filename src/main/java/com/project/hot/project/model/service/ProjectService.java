package com.project.hot.project.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;

public interface ProjectService {

	List<Employee> selectEmpByDept(Map<String,Object> param);
	List<Department> selectDeptAll();
	Map<String,Object> selectProjectAll(Map<String,Integer> param);
	Project selectProjectByNo(int projectNo);
	List<ProjectEmployee> selectEmployeetByProjectNo(Map<String,Integer> param);
	int insertProject(Project p);
	int updateProject(Project p);
	int deleteProject(int projectNo);
}
