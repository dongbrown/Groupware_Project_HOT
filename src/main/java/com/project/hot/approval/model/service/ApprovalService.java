package com.project.hot.approval.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface ApprovalService {

	List<Approval> getAllDocuments();
	List<Employee> getEmployeesByDepartment(String departmentCode);
	List<Department> selectDepartmentList();
	Map<String, Object> getApprovalsCountAndList(Map<String, Object> param);
}
