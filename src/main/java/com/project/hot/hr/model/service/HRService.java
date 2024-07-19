package com.project.hot.hr.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.hr.model.dto.RequestCommuting;
import com.project.hot.hr.model.dto.RequestDepartment;

public interface HRService {
	Map<String, Object> selectDepartmentListForHR(Map<String, Object> param);
	int insertDepartment(RequestDepartment rd);
	int updateDepartment(RequestDepartment rd);
	int deleteDepartment(RequestDepartment rd);
	int deleteEmployee(int no);
	int updateEmployee(RequestEmployee re);
	int insertEmployee(RequestEmployee re);
	Map<String, Object> selectAllEmpCommuting(Map<String, Object> param);
	int deleteCommuting(int no);
	int updateCommuting(RequestCommuting rc);
	List<Employee> selectAllEmp();
}
