package com.project.hot.project.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Override
	public List<Employee> selectEmpByDept(SqlSession session, int deptCode) {
		return session.selectList("project.selectEmpByDept",deptCode);
	}

	@Override
	public int insertProject(SqlSession session, Project p) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProject(SqlSession session, Project p) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProject(SqlSession session, int projectNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Project selectProjectAll(SqlSession session) {
		// TODO Auto-generated method stub
		return null;
	}

}
