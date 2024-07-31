package com.project.hot.approval.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.CommutingTimeForm;
import com.project.hot.approval.model.dto.OvertimeForm;
import com.project.hot.approval.model.dto.RequestBusinessTrip;
import com.project.hot.approval.model.dto.VacationForm;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface ApprovalService {

	List<Approval> getAllDocuments();
	List<Employee> getEmployeesByDepartment(String departmentCode);
	List<Department> selectDepartmentList();
	Map<String, Object> getApprovalsCountAndList(Map<String, Object> param);
	String insertApproval(Map<String, Object> param);
	int insertVacation(VacationForm vf);
	int insertCommuting(CommutingTimeForm ctf);
	int insertOvertime(OvertimeForm of);
	int insertBusinessTrip(RequestBusinessTrip rbt);
}
