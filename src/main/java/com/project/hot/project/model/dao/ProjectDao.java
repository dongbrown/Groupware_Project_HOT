package com.project.hot.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.ProjectEmployee;
import com.project.hot.project.model.dto.RequestProject;

public interface ProjectDao {

	List<Employee> selectEmpByDept(SqlSession session,Map<String,Object> param);
	List<Department> selectDeptAll(SqlSession session);
	Project selectProjectByNo(SqlSession session,int projectNo);
	int selectProjectAllCount(SqlSession session);
	int insertProject(SqlSession session,Project p);
	List<ProjectEmployee> selectEmployeetByProjectNo(SqlSession session,Map<String,Integer> param);
	int requestJoinProject(SqlSession session,Map<String,Integer> param);
	List<Project> requestProjectlistall(SqlSession session,Map<String,Integer> param);
	List<Project> responseProjectlistall(SqlSession session,Map<String,Integer> param);
	int requestProjectlistallCount(SqlSession session,Map<String,Integer> param);
	int responseProjectlistallCount(SqlSession session,Map<String,Integer> param);
	int insertProjectEmp(SqlSession session,Map<String,Object> param);
	int updateProject(SqlSession session,Project p);
	int updateProjectDeleteEmp(SqlSession session,Map<String,Integer> param);
	int deleteProject(SqlSession session,int projectNo);
	List<Project> selectProjectAll(SqlSession session,Map<String,Integer> param);
	List<Project> selectProjectAllByEmpNo(SqlSession session, Map<String, Integer> param);
	int selectProjectAllCountByEmpNo(SqlSession session, Map<String, Integer> param);
	int responseApprovalInsert(SqlSession session, Map<String, Integer> param);
	int responseApprovalDelete(SqlSession session, Map<String, Integer> param);
	int requestRefuseUpdate(SqlSession session, Map<String, Object> param);
	int refusedCheckDelete(SqlSession session, Map<String, Integer> param);

}
