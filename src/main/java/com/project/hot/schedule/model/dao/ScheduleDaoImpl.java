package com.project.hot.schedule.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.schedule.model.dto.Schedule;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	@Override
	public List<Schedule> getSchedules(SqlSession session) {
		return session.selectList("schedule.getSchedule");
	}

	@Override
	public void addSchedule(Schedule schedule, SqlSession session) {
		session.insert("schedule.addSchedule", schedule);
	}

	@Override
	public void updateSchedule(Schedule schedule, SqlSession session) {
		session.update("schedule.updateSchedule", schedule);
	}

	@Override
	public int deleteSchedule(String id, SqlSession session) {
		return session.delete("schedule.deleteSchedule", id);
	}

}
