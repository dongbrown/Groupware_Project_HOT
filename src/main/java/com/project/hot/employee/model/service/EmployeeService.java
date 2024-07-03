package com.project.hot.employee.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.employee.model.dto.Employee;

public interface EmployeeService {

	Employee selectEmployeeById(String id);
	Map<String, Object> selectEmployees(Map<String, Object> param);
}
