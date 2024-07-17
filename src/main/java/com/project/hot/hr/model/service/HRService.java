package com.project.hot.hr.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.hr.model.dto.RequestDepartment;
import com.project.hot.hr.model.dto.ResponseDepartment;

public interface HRService {
	Map<String, Object> selectDepartmentListForHR(Map<String, Object> param);
	int insertDepartment(RequestDepartment rd);
	int updateDepartment(RequestDepartment rd);
	int deleteDepartment(RequestDepartment rd);
	int deleteEmployee(int no);
}
