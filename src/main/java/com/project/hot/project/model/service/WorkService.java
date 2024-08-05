package com.project.hot.project.model.service;

import java.util.List;
import java.util.Map;

import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.Work;

public interface WorkService {

	int insertWorkDetail(Work work);
	Map<String,Object> selectProjectAll(Map<String,Integer> param);
	int updateWorkDetail(Work work);
	int deleteWorkAtt(List<String> delAttName);
	int insertWorkAtt(Map<String,Object> param);
	Map<String,Object> selectWorkAll(Map<String,Integer> param);
	Work selectWorkByWorkNo(int workNo);
	List<String> selectDeleteAttList(int workNo);
	int deleteWorkAtt(int workNo);
	int deleteWork(int workNo);
}
