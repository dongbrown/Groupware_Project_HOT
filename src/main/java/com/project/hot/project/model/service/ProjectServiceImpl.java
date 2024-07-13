package com.project.hot.project.model.service;

import java.util.HashMap;
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
	public List<Employee> selectEmpByDept(Map<String,Object> param) {
		return dao.selectEmpByDept(session, param);
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
		int result = dao.updateProject(session, p);
		if(result>0) {
			int deleteResult=dao.updateProjectDeleteEmp(session, p.getProjectNo());
			if(deleteResult>0) {
				p.getEmployee().forEach(e -> {
					dao.insertProjectEmp(session, Map.of("projectNo", p.getProjectNo(), "empNo", e.getEmployeeNo()));
				});
			}
		}
		return result;
	}

	@Override
	public int deleteProject(int projectNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<String,Object> selectProjectAll(Map<String,Integer> param) {
		Map<String,Object> result=new HashMap<>();
		if(param.get("employeeNo")==null) {
			result.put("depts", dao.selectDeptAll(session));
			result.put("projects", dao.selectProjectAll(session,param));
			result.put("totalPage",Math.ceil((double)dao.selectProjectAllCount(session)/param.get("numPerpage")));
		}else {
			result.put("depts", dao.selectDeptAll(session));
			result.put("projects", dao.selectProjectAllByEmpNo(session,param));
			result.put("totalPage",Math.ceil((double)dao.selectProjectAllCountByEmpNo(session,param)/param.get("numPerpage")));
		}
		return result;
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
	public List<ProjectEmployee> selectEmployeetByProjectNo(Map<String,Integer> param) {
		return dao.selectEmployeetByProjectNo(session, param);
	}

}
