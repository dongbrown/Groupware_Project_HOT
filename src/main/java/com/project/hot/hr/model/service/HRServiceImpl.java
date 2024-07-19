package com.project.hot.hr.model.service;

import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dao.EmployeeDao;
import com.project.hot.employee.model.dto.Employee;
import com.project.hot.employee.model.dto.RequestEmployee;
import com.project.hot.hr.model.dao.HRDao;
import com.project.hot.hr.model.dto.RequestCommuting;
import com.project.hot.hr.model.dto.RequestDepartment;
import com.project.hot.hr.model.dto.ResponseCommuting;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HRServiceImpl implements HRService {

	private final HRDao hrDao;
	private final EmployeeDao empDao;
	private final SqlSession session;

	@Override
	public Map<String, Object> selectDepartmentListForHR(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();
		result.put("departments", hrDao.selectDepartmentListForHR(session, param));
		result.put("totalPage", Math.ceil((double)hrDao.totalDepartmentCount(session, param)/10));
		return result;
	}

	@Override
	public int insertDepartment(RequestDepartment rd) {
		if(rd.getHighCode()==2) {
			//인사팀 권한
			rd.setAuth("10");
		}else {
			//나머지 권한
			rd.setAuth("1");
		}
		return hrDao.insertDepartment(session, rd);
	}

	@Override
	public int updateDepartment(RequestDepartment rd) {
		return hrDao.updateDepartment(session, rd);
	}

	@Override
	public int deleteDepartment(RequestDepartment rd) {
		return hrDao.deleteDepartment(session, rd);
	}

	@Override
	public int deleteEmployee(int no) {
		return hrDao.deleteEmployee(session, no);
	}

	@Override
	public int updateEmployee(RequestEmployee re) {
		return hrDao.updateEmployee(session, re);
	}

	@Override
	public int insertEmployee(RequestEmployee re) {
		return hrDao.insertEmployee(session, re);
	}

	@Override
	public Map<String, Object> selectAllEmpCommuting(Map<String, Object> param) {
		Map<String, Object> result=new HashMap<>();
		result.put("totalPage", Math.ceil((double)hrDao.countAllEmpCommuting(session, (RequestCommuting)param.get("rc"))/15));
		List<ResponseCommuting> rc=hrDao.selectAllEmpCommuting(session, param);

		//총 근무 시간 계산
		rc.forEach(e->{
			if(e.getCommutingGoWorkTime()!=null && e.getCommutingLeaveWorkTime()!=null) {
				e.setTotalWorkTime((int)Duration.between(e.getCommutingGoWorkTime(), e.getCommutingLeaveWorkTime()).toMinutes() / 60);
			}
		});

		result.put("commutings", rc);
		return result;
	}

	@Override
	public int deleteCommuting(int no) {
		return hrDao.deleteCommuting(session, no);
	}

	@Override
	public int updateCommuting(RequestCommuting rc) {
		return hrDao.updateCommuting(session, rc);
	}

	@Override
	public List<Employee> selectAllEmp() {
		return hrDao.selectAllEmp(session);
	}

}
