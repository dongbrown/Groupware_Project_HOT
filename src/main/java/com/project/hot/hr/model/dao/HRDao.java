package com.project.hot.hr.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.hr.model.dto.RequestDepartment;
import com.project.hot.hr.model.dto.ResponseDepartment;

public interface HRDao {
	List<ResponseDepartment> selectDepartmentListForHR(SqlSession session, Map<String, Object> param);
	int totalDepartmentCount(SqlSession session, Map<String, Object> param);
	int insertDepartment(SqlSession session, RequestDepartment rd);
	int updateDepartment(SqlSession session, RequestDepartment rd);
	int deleteDepartment(SqlSession session, RequestDepartment rd);
	int updateEmployee(SqlSession session, RequestEmployee re);
	int deleteEmployee(SqlSession session, int no);
}
