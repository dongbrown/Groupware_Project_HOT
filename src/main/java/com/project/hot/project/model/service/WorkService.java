package com.project.hot.project.model.service;

import java.util.Map;

import com.project.hot.project.model.dto.Work;

public interface WorkService {

	int insertWorkDetail(Work work);
	int insertWorkAtt(Map<String,Object> param);
}
