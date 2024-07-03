package com.project.hot.employee.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.employee.model.dto.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	@Override
	public Employee selectEmployeeById(SqlSession session, String id) {
		return session.selectOne("employee.selectEmployeeById", id);
	}

}
