package com.project.hot.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.employee.model.dto.Commuting;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.RequestEmployee;

public interface EmployeeDao {
	Employee selectEmployeeById(SqlSession session, String id);
	List<Employee> selectEmployeeList(SqlSession session, Map<String, Object> param);
	int countEmployeeTotalData(SqlSession session, Map<String, Object> param);
	List<Department> selectDepartmentList(SqlSession session);
	List<Commuting> selectCommutingPagingList(SqlSession session, Map<String, Object> param);
	int countCommutingTotalData(SqlSession session, Map<String, Object> param);
	List<Commuting> selectCommutingList(SqlSession session, Map<String, Object> param);
	int updateEmployeePhoto(SqlSession session, Map<String, Object> param);
	int updateEmployee(SqlSession session, RequestEmployee requestEmployee);
	int insertCommuting(SqlSession session, Map<String, Object> param);
	int updateCommuting(SqlSession session, Map<String, Object> param);
	int insertCommutingNoAtt(SqlSession session, Map<String, Object> param);
	Commuting selectCommutingByName(SqlSession session, String employeeId);
	List<String> selectAllEmployeeId(SqlSession session);
	Commuting selectTodayCommuting(SqlSession session, Map<String, Object> param);
	Integer selectTotalOvertimeHour(SqlSession session, Map<String, Object> param);
	List<Approval> selectVacationList(SqlSession session, Map<String, Object> param);
	int countVacationList(SqlSession session, Map<String, Object> param);
	double sumVacationDay(SqlSession session, Map<String, Object> param);
	int selectEmployeeTotalVacation(SqlSession session, Map<String, Object> param);
}
