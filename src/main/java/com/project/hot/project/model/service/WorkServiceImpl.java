package com.project.hot.project.model.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.project.model.dao.WorkDao;
import com.project.hot.project.model.dto.Work;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class WorkServiceImpl implements WorkService {

	private final SqlSession session;
	private final WorkDao dao;

	@Override
	public int insertWorkDetail(Work work) {
		return dao.insertWorkDetail(session, work);
	}

	@Override
	public int insertWorkAtt(Map<String, Object> param) {
		return dao.insertWorkAtt(session, param);
	}

}
