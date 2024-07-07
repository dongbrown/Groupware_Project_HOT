package com.project.hot.project.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dao.ProjectDao;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;

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
		int result = dao.insertProject(session, p);
		if (result > 0) {
			p.getEmployee().forEach(e -> {
				dao.insertProjectEmp(session, Map.of("projectNo", p.getProjectNo(), "empNo", e.getEmployeeNo()));
			});
		};
		return result;
	}

	@Override
	public int updateProject(Project p) {
		int deleteResult = 0;
		int result = dao.updateProject(session, p);
		if(result>0) {
			deleteResult=dao.updateProjectDeleteEmp(session, p.getProjectNo());
			if(deleteResult>0) {
				p.getEmployee().forEach(e -> {
					dao.insertProjectEmp(session, Map.of("projectNo", p.getProjectNo(), "empNo", e.getEmployeeNo()));
				});
			}
		}
		return deleteResult;
	}

	@Override
	public int deleteProject(int projectNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Project> selectProjectAll(Map<String,Integer> param) {
		return dao.selectProjectAll(session,param);
	}

	@Override
	public List<Department> selectDeptAll() {
		return dao.selectDeptAll(session);
	}

	@Override
	public Project selectProjectByNo(int projectNo) {
		return dao.selectProjectByNo(session, projectNo);
	}

	@Override
	public List<ProjectEmployee> selectEmployeetByProjectNo(int projectNo) {
		return dao.selectEmployeetByProjectNo(session, projectNo);
	}

}
