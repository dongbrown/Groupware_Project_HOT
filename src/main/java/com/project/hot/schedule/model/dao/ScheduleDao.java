package com.project.hot.schedule.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.schedule.model.dto.Schedule;
import com.project.hot.schedule.model.dto.ScheduleEmployee;

public interface ScheduleDao {

	List<Schedule> getSchedules(SqlSession session, int employeeNo);

	int addSchedule(Schedule schedule, SqlSession session, int employeeNo);

	void addScheduleEmployee(ScheduleEmployee se, SqlSession session);

	void updateSchedule(Schedule schedule, SqlSession session);

	void deleteSchedule(int id, SqlSession session);

	void deleteScheduleEmployee(int id, SqlSession session);

	List<Employee> getEmployeesByDepartment(String deptCode, SqlSession session);

	List<Schedule> getMySchedule(SqlSession session, int employeeNo);

	List<Schedule> getShareSchedule(SqlSession session, int employeeNo);



}
