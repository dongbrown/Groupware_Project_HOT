package com.project.hot.schedule.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.employee.model.dto.Employee;
import com.project.hot.schedule.model.dto.Schedule;
import com.project.hot.schedule.model.dto.ScheduleEmployee;

import jakarta.mail.Session;

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
	public void addScheduleEmployee(ScheduleEmployee se, SqlSession session) {
        session.insert("schedule.addScheduleEmployee", se);
	}

	//전사 일정 추가
	@Override
	public void addCompanySchedule(Schedule schedule, SqlSession session) {
		session.insert("schedule.addCompanySchedule", schedule);
	}

	@Override
	public void updateScheduleByDrag(Schedule schedule, SqlSession session) {
		session.update("schedule.updateScheduleByDrag", schedule);
	}

	@Override
	public void updateSchedule(Schedule schedule, SqlSession session) {
		session.update("schedule.updateSchedule", schedule);
	}

	@Override
	public void deleteSchedule(int id, SqlSession session) {
		session.delete("schedule.deleteSchedule", id);
	}


	@Override
	public void deleteScheduleEmployee(int id, SqlSession session) {
		session.delete("schedule.deleteScheduleEmployee", id);
	}

	@Override
	public List<Employee> getEmployeesByDepartment(String deptCode, SqlSession session) {
		return session.selectList("schedule.getEmployeesByDepartment", deptCode);
	}

	@Override
	public List<Schedule> getMySchedule(SqlSession session, int employeeNo) {
		return session.selectList("schedule.getMySchedule", employeeNo);
	}

	@Override
	public List<Schedule> getShareSchedule(SqlSession session, int employeeNo) {
		return session.selectList("schedule.getShareSchedule", employeeNo);
	}

	@Override
	public List<Schedule> getCompanySchedule(SqlSession session) {
		return session.selectList("schedule.getCompanySchedule");
	}

	@Override
	public List<Schedule> getTodaySchedules(SqlSession session, int employeeNo) {
		return session.selectList("schedule.getTodaySchedule", employeeNo);
	}

}
