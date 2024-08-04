package com.project.hot.project.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;
import com.project.hot.project.model.dto.RequestProject;

public interface ProjectService {

	List<Employee> selectEmpByDept(Map<String,Object> param);
	List<Department> selectDeptAll();
	Map<String,Object> selectProjectAll(Map<String,Integer> param);
	Map<String,Object> updateProjectAll(Map<String,Integer> param);
	Project selectProjectByNo(int projectNo);
	List<ProjectEmployee> selectEmployeetByProjectNo(Map<String,Integer> param);
	int requestJoinProject(Map<String,Integer> param);
	Map<String,Object> requestProjectlistall(Map<String,Integer> param);
	Map<String,Object> responseProjectlistall(Map<String,Integer> param);
	int insertProject(Project p);
	int updateProject(Project p);
	int deleteProject(int projectNo);
	int responseApproval(Map<String, Integer> param);
	int requestRefuseUpdate(Map<String, Object> param);
	int refusedCheckDelete(Map<String, Integer> param);
	List<String> selectDeleteAttList(int projectNo);
	int deleteProjectWorkAtt(int projectNo);
}
