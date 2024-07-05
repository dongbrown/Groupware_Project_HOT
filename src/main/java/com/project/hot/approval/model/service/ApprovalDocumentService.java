package com.project.hot.approval.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;

public interface ApprovalDocumentService {

	List<Approval> getAllDocuments();
	Map<String, Object> inputVacationForm(VacationForm vacationForm);
}
