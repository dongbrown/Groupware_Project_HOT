package com.project.hot.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface EmployeeDao {
	Employee selectEmployeeById(SqlSession session, String id);
	List<Employee> selectEmployees(SqlSession session, Map<String, Object> param);
	int countEmployeeTotalData(SqlSession session);
	List<Department> selectDepartmentTitle(SqlSession session);
}
