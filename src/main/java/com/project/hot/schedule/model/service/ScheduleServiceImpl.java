package com.project.hot.schedule.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.schedule.model.dao.ScheduleDao;
import com.project.hot.schedule.model.dto.Schedule;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ScheduleServiceImpl implements ScheduleService{

	   private final ScheduleDao dao;
	   private final SqlSession session;

	@Override
	public List<Schedule> getSchedules() {
        return dao.getSchedules(session);
	}

	@Override
	public void addSchedule(Schedule schedule) {
		dao.addSchedule(schedule, session);
	}

	@Override
    public void updateSchedule(Schedule schedule) {
        dao.updateSchedule(schedule, session);
    }


	@Override
	public int deleteSchedule(String id) {
		return dao.deleteSchedule(id, session);
	}

}
