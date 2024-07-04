package com.project.hot.approval.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hot.approval.model.dao.ApprovalDocumentDao;
import com.project.hot.approval.model.dto.Approval;

@Service
public class ApprovalDocumentServiceImpl implements ApprovalDocumentService {

    @Autowired
    private ApprovalDocumentDao approvalDocumentDao;

    @Override
    public List<Approval> getAllDocuments() {
        return approvalDocumentDao.AllDocuments();
    }
}
