package com.project.hot.approval.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ApprovalDocumentDaoImpl implements ApprovalDocumentDao {

	private final SqlSession session;

    @Override
    public List<Approval> AllDocuments(SqlSession session) {
        return session.selectList("approval.approvalAll");
    }

    @Override
    public List<Employee> getEmployeesByDepartment(SqlSession session, String departmentCode) {
        return session.selectList("approval.getEmployeesByDepartment", departmentCode);
    }

    @Override
    public List<Department> selectDepartmentList(SqlSession session) {
        return session.selectList("approval.selectDepartmentList");
    }
}