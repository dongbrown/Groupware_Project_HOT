package com.project.hot.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.approval.model.dto.Approval;
import com.project.hot.approval.model.dto.BusinessTripForm;
import com.project.hot.approval.model.dto.CommutingTimeForm;
import com.project.hot.approval.model.dto.OvertimeForm;
import com.project.hot.approval.model.dto.RequestApproval;
import com.project.hot.approval.model.dto.RequestBusinessTrip;
import com.project.hot.approval.model.dto.VacationForm;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

public interface ApprovalDao {

	List<Approval> AllDocuments(SqlSession session);
	List<Employee> getEmployeesByDepartment(SqlSession session, String departmentCode);
	List<Department> selectDepartmentList(SqlSession session);
	int selectApprovalWaitCount(SqlSession session, int no);
	int selectApprovalProcessCount(SqlSession session, int no);
	int selectApprovalPendingCount(SqlSession session, int no);
	int selectApprovalCompleteCount(SqlSession session, int no);
	int selectApprovalAllCount(SqlSession session, int no);
	List<Approval> selectApprovalAllList(SqlSession session, Map<String, Object> param);
	String insertApproval(SqlSession session, Map<String, Object> param);
	int insertVacation(SqlSession session, VacationForm vf);
	int insertCommuting(SqlSession session, CommutingTimeForm ctf);
	int insertOvertime(SqlSession session, OvertimeForm of);
	int insertBusinessTrip(SqlSession session, RequestBusinessTrip rbt);
	int insertBusinessPartner(SqlSession session, RequestBusinessTrip rbt);
}