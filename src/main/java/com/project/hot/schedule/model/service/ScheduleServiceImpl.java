package com.project.hot.schedule.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.schedule.model.dao.ScheduleDao;
import com.project.hot.schedule.model.dto.Schedule;
import com.project.hot.schedule.model.dto.ScheduleEmployee;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ScheduleServiceImpl implements ScheduleService{

	   private final ScheduleDao dao;
	   private final SqlSession session;

	@Override
	public List<Schedule> getSchedules(int employeeNo) {
        return dao.getSchedules(session, employeeNo);
	}

	@Override
	@Transactional
	public void addSchedule(Schedule schedule, int employeeNo) {

		//Schedule 추가
		int scheduleNo = dao.addSchedule(schedule, session, employeeNo);

		//ScheduleEmployee 추가
		ScheduleEmployee se = ScheduleEmployee.builder()
				.employeeNo(employeeNo)
				.scheduleNo(scheduleNo)
				.build();
		dao.addScheduleEmployee(se, session);

	}

	@Override
    public void updateSchedule(Schedule schedule) {
        dao.updateSchedule(schedule, session);
    }


	@Override
	@Transactional
	public void deleteSchedule(int id) {
		// Schedule 삭제
		dao.deleteSchedule(id, session);
		// ScheduleEmployee 삭제
		dao.deleteScheduleEmployee(id, session);
	}

	@Override
	public List<Employee> getEmployeesByDepartment(String deptCode) {
		return dao.getEmployeesByDepartment(deptCode, session);
	}

}
