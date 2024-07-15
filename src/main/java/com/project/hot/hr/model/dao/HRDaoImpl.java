package com.project.hot.hr.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.project.hot.hr.model.dto.ResponseDepartment;

@Repository
public class HRDaoImpl implements HRDao {

	@Override
	public List<ResponseDepartment> selectDepartmentListForHR(SqlSession session, Map<String, Object> param) {
		return session.selectList("hr.departmentList", param,
				new RowBounds(((int)param.get("cPage")-1)*(int)param.get("numPerpage"), (int)param.get("numPerpage")));
	}

	@Override
	public int totalDepartmentCount(SqlSession session, Map<String, Object> param) {
		return session.selectOne("hr.totalDepartmentCount", param);
	}

}
