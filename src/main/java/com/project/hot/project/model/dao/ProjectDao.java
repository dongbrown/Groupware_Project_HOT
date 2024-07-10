package com.project.hot.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;

public interface ProjectDao {

	List<Employee> selectEmpByDept(SqlSession session,Map<String,Object> param);
	List<Department> selectDeptAll(SqlSession session);
	Project selectProjectByNo(SqlSession session,int projectNo);
	int selectProjectAllCount(SqlSession session);
	int insertProject(SqlSession session,Project p);
	List<ProjectEmployee> selectEmployeetByProjectNo(SqlSession session,Map<String,Integer> param);
	int insertProjectEmp(SqlSession session,Map<String,Object> param);
	int updateProject(SqlSession session,Project p);
	int updateProjectDeleteEmp(SqlSession session,int projectNo);
	int deleteProject(SqlSession session,int projectNo);
	List<Project> selectProjectAll(SqlSession session,Map<String,Integer> param);

}
