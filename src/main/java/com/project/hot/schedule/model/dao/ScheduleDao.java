package com.project.hot.schedule.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.schedule.model.dto.Schedule;

public interface ScheduleDao {

	List<Schedule> getSchedules(SqlSession session);

	void addSchedule(Schedule schedule, SqlSession session);

	void updateSchedule(Schedule schedule, SqlSession session);

	int deleteSchedule(String id, SqlSession session);


}
