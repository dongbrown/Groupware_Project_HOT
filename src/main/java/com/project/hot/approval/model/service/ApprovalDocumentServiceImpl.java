package com.project.hot.approval.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hot.approval.model.dao.ApprovalDocumentDao;
import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;

import java.util.List;

@Service
public class ApprovalDocumentServiceImpl implements ApprovalDocumentService {

    @Autowired
    private ApprovalDocumentDao approvalDocumentDao;

    @Override
    public List<Approval> getAllDocuments() {
        return approvalDocumentDao.AllDocuments();
    }

    @Override
    public List<String> getEmployeesByDepartment(String department) {
        return approvalDocumentDao.getEmployeesByDepartment(department);
    }
}
