package com.project.hot.employee.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Employee;

public interface EmployeeDao {
	Employee selectEmployeeById(SqlSession session, String id);
}
