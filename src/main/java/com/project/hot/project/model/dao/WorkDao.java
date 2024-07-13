package com.project.hot.project.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.project.model.dto.Work;

public interface WorkDao {

	int insertWorkDetail(SqlSession session, Work work);
	int insertWorkAtt(SqlSession session, Map<String,Object> param);
}
