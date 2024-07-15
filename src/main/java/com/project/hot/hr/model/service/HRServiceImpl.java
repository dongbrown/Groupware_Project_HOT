package com.project.hot.hr.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.employee.model.dao.EmployeeDao;
import com.project.hot.hr.model.dao.HRDao;

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

}
