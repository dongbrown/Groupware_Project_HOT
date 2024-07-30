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
import lombok.extern.slf4j.Slf4j;
@Service
@RequiredArgsConstructor
@Slf4j
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
			int deleteResult=dao.updateProjectDeleteEmp(session, Map.of("projectNo",p.getProjectNo(),"employeeNo",p.getEmployeeNo()));
			System.out.println("지워질 항목 : "+p.getEmployeeNo());
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
		if(param.get("employeeNo")==0) {
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

	@Override
	public int requestJoinProject(Map<String, Integer> param) {
		return dao.requestJoinProject(session, param);
	}

	@Override
	public Map<String,Object> requestProjectlistall(Map<String, Integer> param) {
		Map<String,Object> result=new HashMap<>();
		result.put("projects", dao.requestProjectlistall(session, param));
		result.put("totalPage",Math.ceil((double)dao.requestProjectlistallCount(session,param)/param.get("numPerpage")));
		return result;
	}

	@Override
	public Map<String, Object> responseProjectlistall(Map<String, Integer> param) {
		Map<String,Object> result=new HashMap<>();
		result.put("projects", dao.responseProjectlistall(session, param));
		result.put("totalPage",Math.ceil((double)dao.responseProjectlistallCount(session,param)/param.get("numPerpage")));
		return result;
	}

	@Override
	public int responseApproval(Map<String, Integer> param) {
		int insertResult=0;
		try {
			//프로젝트 참여 요청 - 프로젝트 맴버s테이블에 insert
			insertResult = dao.responseApprovalInsert(session, param);
			if(insertResult>0) {
				//프로젝트 요청 테이블에서 프로젝트 맴버테이블에 삽입 성공 시 삭제 진행
				int updateResult = dao.responseApprovalDelete(session, param);
				if(updateResult<=0) {
					throw new RuntimeException("프로젝트 요청 승인 - 맴버테이블 삭제 실패");
				}
			}else {
				throw new RuntimeException("프로젝트 요청 승인 - 프로젝트 멤버 테이블 삽입 실패");
			}
		}catch(Exception e) {
	        log.error("responseApproval 처리 중 오류 발생: " + e.getMessage(), e);
	        throw new RuntimeException("responseApproval 처리 중 오류 발생", e);
		}
		return insertResult;
	}

	@Override
	public int requestRefuseUpdate(Map<String, Object> param) {
		return dao.requestRefuseUpdate(session, param);
	}

	@Override
	public int refusedCheckDelete(Map<String, Integer> param) {
		return dao.refusedCheckDelete(session, param);
	}

}
