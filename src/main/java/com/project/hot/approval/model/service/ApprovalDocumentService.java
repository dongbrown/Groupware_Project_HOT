package com.project.hot.approval.model.service;

import java.util.List;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface ApprovalDocumentService {

	List<Approval> getAllDocuments();
	List<Employee> getEmployeesByDepartment(String departmentCode);
	List<Department> selectDepartmentList();
}
