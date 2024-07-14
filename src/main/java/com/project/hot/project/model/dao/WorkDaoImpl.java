package com.project.hot.project.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.project.model.dto.Work;
@Repository
public class WorkDaoImpl implements WorkDao {

	@Override
	public int insertWorkDetail(SqlSession session, Work work) {
		return session.insert("work.insertWork", work);
	}

	@Override
	public int insertWorkAtt(SqlSession session, Map<String, Object> param) {
		return session.insert("work.insertWorkAtt", param);
	}

}
