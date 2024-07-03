package com.project.hot.employee.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dao.EmployeeDao;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EmployeeServiceImpl implements EmployeeService {

	private final SqlSession session;
	private final EmployeeDao dao;

	@Override
	public Employee selectEmployeeById(String id) {
		return dao.selectEmployeeById(session, id);
	}

}
