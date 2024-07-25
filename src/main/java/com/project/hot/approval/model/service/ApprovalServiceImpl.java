package com.project.hot.approval.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.approval.model.dao.ApprovalDao;
import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.ResponseApprovalsCount;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {


    private final ApprovalDao dao;
    private final SqlSession session;

    @Override
    public List<Approval> getAllDocuments() {
        return dao.AllDocuments(session);
    }


    @Override
    public List<Employee> getEmployeesByDepartment(String departmentCode) {
        return dao.getEmployeesByDepartment(session, departmentCode);
    }

    @Override
    public List<Department> selectDepartmentList() {
        return dao.selectDepartmentList(session);
    }


	@Override
	public Map<String, Object> getApprovalsCountAndList(int no) {
		Map<String, Object> result=new HashMap<>();

		//각 결재문서 카운트
		ResponseApprovalsCount rac=new ResponseApprovalsCount();
		rac.setWaitCount(dao.selectApprovalWaitCount(session, no));
		rac.setProcessCount(dao.selectApprovalProcessCount(session, no));
		rac.setPendingCount(dao.selectApprovalPendingCount(session, no));
		rac.setCompleteCount(dao.selectApprovalCompleteCount(session, no));
		result.put("rac", rac);

		//결재 문서 리스트 가져오기
		return result;
	}

}
