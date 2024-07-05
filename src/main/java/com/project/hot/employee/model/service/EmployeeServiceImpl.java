package com.project.hot.employee.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dao.EmployeeDao;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EmployeeServiceImpl implements EmployeeService {

	private final SqlSession session;
	private final EmployeeDao dao;

	//사원의 id를 통해 사원정보를 가져옴
	@Override
	public Employee selectEmployeeById(String id) {
		return dao.selectEmployeeById(session, id);
	}

	/*
	 * 사원 리스트, 사원 총 데이터(페이징 용도) 반환
	 */
	@Override
	public Map<String, Object> selectEmployeeList(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();
		result.put("totalData", dao.countEmployeeTotalData(session));
		result.put("employees", dao.selectEmployeeList(session, param));
		return result;
	}

	@Override
	public List<Department> selectDepartmentList() {
		return dao.selectDepartmentList(session);
	}

}
