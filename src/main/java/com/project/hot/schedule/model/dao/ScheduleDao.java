package com.project.hot.schedule.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.schedule.model.dto.Schedule;
import com.project.hot.schedule.model.dto.ScheduleEmployee;

public interface ScheduleDao {

	List<Schedule> getSchedules(SqlSession session, int employeeNo);

	int addSchedule(Schedule schedule, SqlSession session, int employeeNo);

	void updateSchedule(Schedule schedule, SqlSession session);

	int deleteSchedule(String id, SqlSession session);

	void addScheduleEmployee(ScheduleEmployee se, SqlSession session);



}
