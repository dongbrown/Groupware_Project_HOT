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
import com.project.hot.employee.model.dto.RequestEmployee;
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
		result.put("totalPage", Math.ceil((double)dao.countEmployeeTotalData(session, param)/(int)param.get("numPerpage")));
		result.put("employees", dao.selectEmployeeList(session, param));
		return result;
	}

	@Override
	public List<Department> selectDepartmentList() {
		//부서 리스트 가져오기
		return dao.selectDepartmentList(session);
	}

	@Override
	public Map<String, Object> selectCommutingList(Map<String, Object> param) {
		//출퇴근 내역 가져오기
		Map<String, Object> result=new HashMap<>();
		result.put("totalPage", Math.ceil((double)dao.countCommutingTotalData(session, param)/10));
		result.put("commutings", dao.selectCommutingPagingList(session, param));

		//출퇴근 페이지 시간계산
		ResponseCommuting rc=new ResponseCommuting();
		List<Commuting> c=dao.selectCommutingList(session, param);

		//오늘 출퇴근시간 저장
		Commuting today=dao.selectTodayCommuting(session, param);
		if(today != null) {
			if(today.getCommutingGoWorkTime()!=null) rc.setTodayGoWorkTime(today.getCommutingGoWorkTime());
			if(today.getCommutingLeaveWorkTime()!=null) rc.setTodayLeaveWorkTime(today.getCommutingLeaveWorkTime());
		}

		//이번달 근무일수 저장
		rc.setTotalWorkDay((int)c.stream().filter(f->!(f.getCommutingStatus().equals("연차")||f.getCommutingStatus().equals("결근"))).count());

		//총 근무시간, 총 연장근무시간 저장
		// 연차, 결근인 날 빼고 나머지 상태만 계산
		c.stream().filter(f->
			f.getCommutingStatus().equals("정상")
			|| f.getCommutingStatus().equals("지각")
			|| f.getCommutingStatus().equals("반차"))
			.forEach(e->{
				if(e.getCommutingGoWorkTime()!=null&&e.getCommutingLeaveWorkTime()!=null) {
					rc.setTotalWorkTime(rc.getTotalWorkTime()
											+ (int)Duration.between(e.getCommutingGoWorkTime(), e.getCommutingLeaveWorkTime()).toMinutes()
											  / 60);
				}
		});
		int totalOvertimeHour=dao.selectTotalOvertimeHour(session, param);
		rc.setTotalExWorkTime(totalOvertimeHour);
		rc.setTotalWorkTime(rc.getTotalWorkTime()+totalOvertimeHour);

		//지각, 결근, 연차 일 수 저장
		rc.setTardy((int)c.stream().filter(f->f.getCommutingStatus().equals("지각")).count());
		rc.setAbsence((int)c.stream().filter(f->f.getCommutingStatus().equals("결근")).count());
		rc.setAnnual((int)c.stream().filter(f->f.getCommutingStatus().equals("연차")).count());

		result.put("responseCommuting", rc);
		return result;
	}

	@Override
	public int updateEmployeePhoto(Map<String, Object> param) {
		return dao.updateEmployeePhoto(session, param);
	}

	@Override
	public int updateEmployee(RequestEmployee requestEmployee) {
		return dao.updateEmployee(session, requestEmployee);
	}

	@Override
	public int insertCommuting(Map<String, Object> param) {
		//출근하기
		//출근 상태 판단
		if(LocalTime.now().getHour()>=9) {
			param.put("status", "지각");
		}else {
			param.put("status", "정상");
		}
		return dao.insertCommuting(session, param);
	}

	@Override
	public int updateCommuting(Map<String, Object> param) {
		// 퇴근 하기
		return dao.updateCommuting(session, param);
	}

	@Override
	public int insertCommutingNoAtt() {
		// 오늘 출근 안한 사람들 결근,휴가,출장 상태로 등록
		Map<String, Object> param=new HashMap<>();
		param.put("result", 0);
		dao.insertCommutingNoAtt(session, param);
		return (int)param.get("result");
	}

	@Override
	public int checkAtt(String employeeId) {
		// 출퇴근 여부 판단
		Commuting c=dao.selectCommutingByName(session, employeeId);
		if(c==null) {
			//출근 안함
			return 0;
		}else if(c.getCommutingGoWorkTime()!=null && c.getCommutingLeaveWorkTime()==null) {
			//출근함, 퇴근은 안함
			return 1;
		}else {
			//퇴근함
			return 2;
		}
	}

	@Override
	public List<String> selectAllEmployeeId() {
		return dao.selectAllEmployeeId(session);
	}

	@Override
	public Map<String, Object> selectVacationList(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();
		result.put("totalPage", Math.ceil((double)dao.countVacationList(session, param)/10));
		result.put("vacations", dao.selectVacationList(session, param));
		result.put("totalVacationDay", dao.sumVacationDay(session, param));
		result.put("employeeTotalVacation", dao.selectEmployeeTotalVacation(session, param));
		return result;
	}

}
