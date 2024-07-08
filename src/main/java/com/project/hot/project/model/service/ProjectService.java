package com.project.hot.project.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;

public interface ProjectService {

	List<Employee> selectEmpByDept(int deptCode);
	List<Department> selectDeptAll();
	List<Project> selectProjectAll(Map<String,Integer> param);
	Project selectProjectByNo(int projectNo);
	List<ProjectEmployee> selectEmployeetByProjectNo(int projectNo);
	int insertProject(Project p);
	int updateProject(Project p);
	int deleteProject(int projectNo);
}
