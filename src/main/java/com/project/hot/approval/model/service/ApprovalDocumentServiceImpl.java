package com.project.hot.approval.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.approval.model.dao.ApprovalDocumentDao;
import com.project.hot.approval.model.dto.Approval;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalDocumentServiceImpl implements ApprovalDocumentService {


    private final ApprovalDocumentDao dao;
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

}
