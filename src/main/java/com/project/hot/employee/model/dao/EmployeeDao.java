package com.project.hot.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Commuting;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface EmployeeDao {
	Employee selectEmployeeById(SqlSession session, String id);
	List<Employee> selectEmployeeList(SqlSession session, Map<String, Object> param);
	int countEmployeeTotalData(SqlSession session, Map<String, Object> param);
	List<Department> selectDepartmentList(SqlSession session);
	List<Commuting> selectCommutingPagingList(SqlSession session, Map<String, Object> param);
	int countCommutingTotalData(SqlSession session, Map<String, Object> param);
	List<Commuting> selectCommutingList(SqlSession session, Map<String, Object> param);
	int updateEmployeePhoto(SqlSession session, Map<String, Object> param);
}
