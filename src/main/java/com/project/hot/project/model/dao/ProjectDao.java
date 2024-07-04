package com.project.hot.project.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;

public interface ProjectDao {

	List<Employee> selectEmpByDept(SqlSession session,int deptCode);
	int insertProject(SqlSession session,Project p);
	int updateProject(SqlSession session,Project p);
	int deleteProject(SqlSession session,int projectNo);
	Project selectProjectAll(SqlSession session);
}
