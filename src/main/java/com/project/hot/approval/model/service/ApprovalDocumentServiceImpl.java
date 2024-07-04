package com.project.hot.approval.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hot.approval.model.dao.ApprovalDocumentDao;
import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;

@Service
public class ApprovalDocumentServiceImpl implements ApprovalDocumentService {

    @Autowired
    private ApprovalDocumentDao approvalDocumentDao;

    @Override
    public List<Approval> getAllDocuments() {
        return approvalDocumentDao.AllDocuments();
    }

    @Override
    public Map<String, Object> inputVacationForm(VacationForm vacationForm) {
        return approvalDocumentDao.inputVacationForm(vacationForm);
    }


}
