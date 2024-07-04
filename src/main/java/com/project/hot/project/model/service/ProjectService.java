package com.project.hot.project.model.service;

import java.util.List;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;

public interface ProjectService {

	List<Employee> selectEmpByDept(int deptCode);
	int insertProject(Project p);
	int updateProject(Project p);
	int deleteProject(int projectNo);
	Project selectProjectAll();
}
