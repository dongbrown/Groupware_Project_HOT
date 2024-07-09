package com.project.hot.schedule.model.service;

import java.util.List;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.schedule.model.dto.Schedule;

public interface ScheduleService {

	List<Schedule> getSchedules(int employeeNo);

	void addSchedule(Schedule schedule, int employeeNo);

	void updateSchedule(Schedule schedule);

	void deleteSchedule(int id);

	List<Employee> getEmployeesByDepartment(String deptCode);

	List<Schedule> getMySchedule(int employeeNo);

	List<Schedule> getShareSchedule(int employeeNo);

}
