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
import com.project.hot.project.model.dto.RequestProject;
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
		return session.delete("project.deleteProject",projectNo);
	}

	@Override
	public int deleteProjectMember(SqlSession session, int projectNo) {
		return session.delete("project.deleteProjectMember",projectNo);
	}

	@Override
	public int deleteProjectWork(SqlSession session, int projectNo) {
		return session.delete("project.deleteProjectWork",projectNo);
	}

	@Override
	public List<Project> selectProjectAll(SqlSession session,Map<String,Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		List<Project> result=session.selectList("project.selectProjectAll",param,rb);
		return result;
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
	public int updateProjectDeleteEmp(SqlSession session, Map<String,Integer>param) {
		return session.delete("project.updateProjectDeleteEmp",param);
	}

	@Override
	public int requestJoinProject(SqlSession session, Map<String, Integer> param) {
		return session.insert("project.requestJoinProject",param);
	}

	@Override
	public List<Project> requestProjectlistall(SqlSession session, Map<String, Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		return session.selectList("project.requestProjectlistall",param.get("employeeNo"),rb);
	}

	@Override
	public int requestProjectlistallCount(SqlSession session, Map<String, Integer> param) {
		return session.selectOne("project.requestProjectlistallCount",param.get("employeeNo"));
	}

	@Override
	public List<RequestProject> responseProjectlistall(SqlSession session, Map<String, Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		List<RequestProject> result = session.selectList("project.responseProjectlistall",param.get("employeeNo"),rb);
		result.forEach(e->{
			System.out.println("왜안나오냐 : "+e);
		});
		return result;
	}

	@Override
	public int responseProjectlistallCount(SqlSession session, Map<String, Integer> param) {
		return session.selectOne("project.responseProjectlistallCount",param.get("employeeNo"));
	}

	@Override
	public int responseApprovalInsert(SqlSession session, Map<String, Integer> param) {
		return session.insert("project.responseApprovalInsert",param);
	}

	@Override
	public int responseApprovalDelete(SqlSession session, Map<String, Integer> param) {
		return session.delete("project.responseApprovalDelete",param);
	}

	@Override
	public int requestRefuseUpdate(SqlSession session, Map<String, Object> param) {
		return session.update("project.requestRefuseUpdate",param);
	}

	@Override
	public int refusedCheckDelete(SqlSession session, Map<String, Integer> param) {
		return session.delete("project.refusedCheckDelete",param);
	}

	@Override
	public List<Project> updateProjectAll(SqlSession session, Map<String, Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		List<Project> result=session.selectList("project.updateProjectAll",param,rb);
		return result;
	}

	@Override
	public int updateProjectAllCount(SqlSession session, Map<String, Integer> param) {
		return session.selectOne("project.updateProjectAllCount");
	}

	@Override
	public List<String> selectDeleteAttList(SqlSession session, int projectNo) {
		return session.selectList("project.selectDeleteAttList",projectNo);
	}

	@Override
	public int deleteProjectWorkAtt(SqlSession session, int projectNo) {
		return session.delete("project.deleteProjectWorkAtt",projectNo);
	}


}
