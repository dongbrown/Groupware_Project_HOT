package com.project.hot.hr.model.service;

import java.util.Map;

import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.hr.model.dto.RequestDepartment;

public interface HRService {
	Map<String, Object> selectDepartmentListForHR(Map<String, Object> param);
	int insertDepartment(RequestDepartment rd);
	int updateDepartment(RequestDepartment rd);
	int deleteDepartment(RequestDepartment rd);
	int deleteEmployee(int no);
	int updateEmployee(RequestEmployee re);
	int insertEmployee(RequestEmployee re);
}
