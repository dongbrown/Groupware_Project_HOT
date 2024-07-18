package com.project.hot.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.project.model.dto.Project;
import com.project.hot.project.model.dto.Work;

public interface WorkDao {

	int insertWorkDetail(SqlSession session, Work work);
	int updateWorkDetail(SqlSession session,Work work);
	int deleteWorkAtt(SqlSession session,List<String> delAttName);
	int insertWorkAtt(SqlSession session, Map<String,Object> param);
	List<Work> selectWorkAllByEmpNo(SqlSession session,Map<String,Integer> param);
	List<Work> selectWorkAll(SqlSession session,Map<String,Integer> param);
	int selectworkAllCountByEmpNo(SqlSession session,Map<String,Integer> param);
	int selectworkAllCount(SqlSession session);
	Work selectWorkByWorkNo(SqlSession session,int workNo);
	List<Project> selectProjectAll(SqlSession session,Map<String,Integer> param);
	int selectProjectAllCount(SqlSession session,Map<String,Integer> param);
}
