package com.project.hot.employee.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.RequestEmployee;

public interface EmployeeService {

	Employee selectEmployeeById(String id);
	Map<String, Object> selectEmployeeList(Map<String, Object> param);
	List<Department> selectDepartmentList();
	Map<String, Object> selectCommutingList(Map<String, Object> param);
	int updateEmployeePhoto(Map<String, Object> param);
	int updateEmployee(RequestEmployee requestEmployee);
	int insertCommuting(Map<String, Object> param);
}
