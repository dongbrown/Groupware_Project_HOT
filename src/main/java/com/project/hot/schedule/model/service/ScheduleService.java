package com.project.hot.schedule.model.service;

import java.util.List;

import com.project.hot.schedule.model.dto.Schedule;

public interface ScheduleService {

	List<Schedule> getSchedules(int employeeNo);

	void addSchedule(Schedule schedule, int employeeNo);

	void updateSchedule(Schedule schedule);

	int deleteSchedule(String id);

}
