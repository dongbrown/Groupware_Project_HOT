package com.project.hot.schedule.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.schedule.model.dto.Schedule;
import com.project.hot.schedule.model.dto.ScheduleEmployee;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

	@Override
	public List<Schedule> getSchedules(SqlSession session, int employeeNo) {
		return session.selectList("schedule.getSchedule", employeeNo);
	}

	@Override
	public int addSchedule(Schedule schedule, SqlSession session, int employeeNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("schedule", schedule);
        paramMap.put("employeeNo", employeeNo);

        session.insert("schedule.addSchedule", paramMap);
        return schedule.getId();
	}

	@Override
	public void updateSchedule(Schedule schedule, SqlSession session) {
		session.update("schedule.updateSchedule", schedule);
	}

	@Override
	public int deleteSchedule(String id, SqlSession session) {
		return session.delete("schedule.deleteSchedule", id);
	}

	@Override
	public void addScheduleEmployee(ScheduleEmployee se, SqlSession session) {
        session.insert("schedule.addScheduleEmployee", se);
	}

}
