package com.project.hot.hr.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.hr.model.dto.RequestCommuting;
import com.project.hot.hr.model.dto.RequestDepartment;
import com.project.hot.hr.model.dto.ResponseCommuting;
import com.project.hot.hr.model.dto.ResponseDepartment;

public interface HRDao {
	List<ResponseDepartment> selectDepartmentListForHR(SqlSession session, Map<String, Object> param);
	int totalDepartmentCount(SqlSession session, Map<String, Object> param);
	int insertDepartment(SqlSession session, RequestDepartment rd);
	int updateDepartment(SqlSession session, RequestDepartment rd);
	int deleteDepartment(SqlSession session, RequestDepartment rd);
	int updateEmployee(SqlSession session, RequestEmployee re);
	int insertEmployee(SqlSession session, RequestEmployee re);
	int deleteEmployee(SqlSession session, int no);
	int countAllEmpCommuting(SqlSession session, RequestCommuting rc);
	List<ResponseCommuting> selectAllEmpCommuting(SqlSession session, Map<String, Object> param);
	int deleteCommuting(SqlSession session, int no);
	int updateCommuting(SqlSession session, RequestCommuting rc);
	List<Employee> selectAllEmp(SqlSession session);
	List<Approval> selectAllEmpVacation(SqlSession session, Map<String, Object> param);
	int countAllEmpVacation(SqlSession session, Map<String, Object> param);
}
