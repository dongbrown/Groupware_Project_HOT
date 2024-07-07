package com.project.hot.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;

public interface ProjectDao {

	List<Employee> selectEmpByDept(SqlSession session,int deptCode);
	List<Department> selectDeptAll(SqlSession session);
	Project selectProjectByNo(SqlSession session,int projectNo);
	int insertProject(SqlSession session,Project p);
	List<ProjectEmployee> selectEmployeetByProjectNo(SqlSession session,int projectNo);
	int insertProjectEmp(SqlSession session,Map<String,Object> param);
	int updateProject(SqlSession session,Project p);
	int deleteProject(SqlSession session,int projectNo);
	List<Project> selectProjectAll(SqlSession session,Map<String,Integer> param);
}
