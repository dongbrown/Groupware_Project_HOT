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
public class ScheduleServiceImpl implements ScheduleService {
    private final ScheduleDao dao;
    private final SqlSession session;

    @Override
    public List<Schedule> getSchedules(int employeeNo) {
        return dao.getSchedules(session, employeeNo);
    }

    @Override
    @Transactional
    public void addSchedule(Schedule schedule, int employeeNo) {
        // Schedule 추가
        int scheduleNo = dao.addSchedule(schedule, session, employeeNo);

        // 일정 생성자를 ScheduleEmployee에 추가
        ScheduleEmployee creatorSe = ScheduleEmployee.builder()
                .employeeNo(employeeNo)
                .scheduleNo(scheduleNo)
                .build();
        dao.addScheduleEmployee(creatorSe, session);

        // 선택된 참석자들을 ScheduleEmployee에 추가
        if (schedule.getParticipants() != null && !schedule.getParticipants().isEmpty()) {
            for (Integer participantNo : schedule.getParticipants()) {
                // 일정 생성자는 이미 추가되었으므로 중복 추가를 방지
                if (participantNo != employeeNo) {
                    ScheduleEmployee participantSe = ScheduleEmployee.builder()
                            .employeeNo(participantNo)
                            .scheduleNo(scheduleNo)
                            .build();
                    dao.addScheduleEmployee(participantSe, session);
                }
            }
        }
    }

    @Override
    @Transactional
    public void addCompanySchedule(Schedule schedule) {
        dao.addCompanySchedule(schedule, session);
        dao.addScheduleEmployeeAll(session);
    }

    //드래그로 수정
    @Override
	public void updateScheduleByDrag(Schedule schedule) {
    	dao.updateScheduleByDrag(schedule, session);
	}
    //모달로 수정
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

	@Override
	public List<Schedule> getMySchedule(int employeeNo) {
		return dao.getMySchedule(session, employeeNo);
	}

	@Override
	public List<Schedule> getShareSchedule(int employeeNo) {
		return dao.getShareSchedule(session, employeeNo);
	}



}