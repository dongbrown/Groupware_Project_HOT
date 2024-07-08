package com.project.hot.approval.model.dao;

import java.util.List;
import java.util.Map;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.VacationForm;

public interface ApprovalDocumentDao {

	List<Approval> AllDocuments();
	public List<String> getEmployeesByDepartment(String department);
}
