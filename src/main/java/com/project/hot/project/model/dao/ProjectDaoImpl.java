package com.project.hot.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;
@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Override
	public List<Employee> selectEmpByDept(SqlSession session, Map<String,Object> param) {
		return session.selectList("project.selectEmpByDept",param);
	}

	@Override
	public int insertProject(SqlSession session, Project p) {
		System.out.println(p);
		return session.insert("project.insertProject",p);
	}

	@Override
	public int updateProject(SqlSession session, Project p) {
		return session.update("project.updateProject",p);
	}

	@Override
	public int deleteProject(SqlSession session, int projectNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Project> selectProjectAll(SqlSession session,Map<String,Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		return session.selectList("project.selectProjectAll",null,rb);
	}

	@Override
	public List<Project> selectProjectAllByEmpNo(SqlSession session,Map<String,Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		return session.selectList("project.selectProjectAllByEmpNo",param,rb);
	}

	@Override
	public int selectProjectAllCount(SqlSession session) {
		return session.selectOne("project.selectProjectAllCount");
	}

	@Override
	public int selectProjectAllCountByEmpNo(SqlSession session,Map<String,Integer> param) {
		return session.selectOne("project.selectProjectAllCountByEmpNo",param);
	}

	@Override
	public List<Department> selectDeptAll(SqlSession session) {
		return session.selectList("project.selectDeptAll");
	}

	@Override
	public int insertProjectEmp(SqlSession session, Map<String,Object> param) {
		return session.insert("project.insertProjectEmp",param);
	}

	@Override
	public Project selectProjectByNo(SqlSession session, int projectNo) {
		return session.selectOne("project.selectProjectByNo",projectNo);
	}

	@Override
	public List<ProjectEmployee> selectEmployeetByProjectNo(SqlSession session, Map<String,Integer> param) {
		return session.selectList("project.selectEmployeetByProjectNo",param);
	}

	@Override
	public int updateProjectDeleteEmp(SqlSession session, int projectNo) {
		return session.delete("project.updateProjectDeleteEmp",projectNo);
	}

}
