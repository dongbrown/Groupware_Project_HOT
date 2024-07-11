package com.project.hot.employee.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface EmployeeService {

	Employee selectEmployeeById(String id);
	Map<String, Object> selectEmployeeList(Map<String, Object> param);
	List<Department> selectDepartmentList();
	Map<String, Object> selectCommutingList(Map<String, Object> param);
	int updateEmployeePhoto(Map<String, Object> param);
}
