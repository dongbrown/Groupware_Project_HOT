package com.project.hot.employee.model.service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dao.EmployeeDao;
import com.project.hot.employee.model.dto.Commuting;
import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.ResponseCommuting;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EmployeeServiceImpl implements EmployeeService {

	private final SqlSession session;
	private final EmployeeDao dao;

	//사원의 id를 통해 사원정보를 가져옴
	@Override
	public Employee selectEmployeeById(String id) {
		return dao.selectEmployeeById(session, id);
	}

	/*
	 * 사원 리스트, 사원 총 데이터(페이징 용도) 반환
	 */
	@Override
	public Map<String, Object> selectEmployeeList(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();
		result.put("totalPage", Math.ceil((double)dao.countEmployeeTotalData(session, param)/12));
		result.put("employees", dao.selectEmployeeList(session, param));
		return result;
	}

	@Override
	public List<Department> selectDepartmentList() {
		return dao.selectDepartmentList(session);
	}

	@Override
	public Map<String, Object> selectCommutingList(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();
		result.put("totalPage", Math.ceil((double)dao.countCommutingTotalData(session, param)/10));
		result.put("commutings", dao.selectCommutingPagingList(session, param));
		
		//출퇴근 페이지 시간계산
		ResponseCommuting rc=new ResponseCommuting();
		List<Commuting> c=dao.selectCommutingList(session, param);
		
		//오늘 출퇴근시간 저장
		c.stream().filter(f->f.getCommutingGoWorkTime().getDayOfMonth()==LocalDateTime.now().getDayOfMonth()).forEach(e->{
			if(e.getCommutingGoWorkTime()!=null) rc.setTodayGoWorkTime(e.getCommutingGoWorkTime());
			if(e.getCommutingLeaveWorkTime()!=null) rc.setTodayLeaveWorkTime(e.getCommutingLeaveWorkTime());
		});
		
		//이번달 근무일수, 총 근무시간, 총 연장근무시간 저장
		rc.setWorkDays((int)c.stream().filter(f->!(f.getCommutingStatus().equals("연차")||f.getCommutingStatus().equals("결근"))).count());
		
		// 연차, 결근인 날 빼고 나머지 상태만 계산
		// 18시 이후는 연장근무시간에 포함
		c.stream().filter(f->!(f.getCommutingStatus().equals("연차")||f.getCommutingStatus().equals("결근"))).forEach(e->{
			if(e.getCommutingGoWorkTime()!=null&&e.getCommutingLeaveWorkTime()!=null) {
				rc.setTotalWorkTime(rc.getTotalWorkTime() 
										+ Duration.between(e.getCommutingGoWorkTime(), e.getCommutingLeaveWorkTime()).toMinutesPart() 
										  / 60);
				rc.setTotalExWorkTime(rc.getTotalExWorkTime()
										+ Duration.between(LocalDateTime.of(e.getCommutingLeaveWorkTime().toLocalDate(), LocalTime.of(18, 0)), e.getCommutingLeaveWorkTime()).toMinutesPart()
										  / 60);
			}
		});
		
		//지각, 결근, 연차 일 수 저장
		rc.setTardy((int)c.stream().filter(f->f.getCommutingStatus().equals("지각")).count());
		rc.setAbsence((int)c.stream().filter(f->f.getCommutingStatus().equals("결근")).count());
		rc.setAnnual((int)c.stream().filter(f->f.getCommutingStatus().equals("연차")).count());
		
		result.put("responseCommuting", rc);
		return result;
	}

}
