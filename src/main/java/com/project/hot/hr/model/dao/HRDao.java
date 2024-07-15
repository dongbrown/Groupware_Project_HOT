package com.project.hot.hr.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.hr.model.dto.ResponseDepartment;

public interface HRDao {
	List<ResponseDepartment> selectDepartmentListForHR(SqlSession session, Map<String, Object> param);
	int totalDepartmentCount(SqlSession session, Map<String, Object> param);
}
