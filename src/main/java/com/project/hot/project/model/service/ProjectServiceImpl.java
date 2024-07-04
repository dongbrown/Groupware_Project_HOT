package com.project.hot.project.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dao.ProjectDao;
import com.project.hot.project.model.dto.Project;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {

	private final ProjectDao dao;
	private final SqlSession session;

	@Override
	public List<Employee> selectEmpByDept(int deptCode) {
		return dao.selectEmpByDept(session, deptCode);
	}

	@Override
	public int insertProject(Project p) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProject(Project p) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProject(int projectNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Project selectProjectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Department> selectDeptAll() {
		return dao.selectDeptAll(session);
	}

}
