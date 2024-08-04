package com.project.hot.project.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.project.model.dao.WorkDao;
import com.project.hot.project.model.dto.Project;
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

	@Override
	public Map<String,Object> selectWorkAll(Map<String, Integer> param) {
		Map<String,Object> result=new HashMap<>();
		System.out.println("워크 조회하자 : "+param.get("employeeNo")+"  "+param.get("projectNo"));
		if(param.get("projectNo")==0) {
			result.put("works", dao.selectWorkAllByEmpNo(session,param));
			result.put("totalPage",Math.ceil((double)dao.selectworkAllCountByEmpNo(session,param)/param.get("numPerpage")));

		}else if(param.get("employeeNo")==0){
			result.put("works", dao.selectWorkAllByProjectNo(session,param));
			result.put("totalPage",Math.ceil((double)dao.selectWorkAllCountByProjectNo(session,param)/param.get("numPerpage")));

		}else{
			result.put("works", dao.selectWorkAll(session,param));
			result.put("totalPage",Math.ceil((double)dao.selectworkAllCount(session)/param.get("numPerpage")));
		}
		return result;
	}

	@Override
	public Work selectWorkByWorkNo(int workNo) {
		return dao.selectWorkByWorkNo(session, workNo);
	}

	@Override
	public int updateWorkDetail(Work work) {
		return dao.updateWorkDetail(session, work);
	}

	@Override
	public int deleteWorkAtt(List<String> delAttName) {
		return dao.deleteWorkAtt(session, delAttName);
	}

	@Override
	public Map<String,Object> selectProjectAll(Map<String, Integer> param) {
		Map<String,Object> result=new HashMap<>();
		result.put("projects",dao.selectProjectAll(session, param));
		result.put("totalPage",Math.ceil((double)dao.selectProjectAllCount(session, param)/param.get("numPerpage")));
		return result;

	}

	@Override
	public List<String> selectDeleteAttList(int workNo) {
		return dao.selectDeleteAttList(session, workNo);
	}

	@Override
	public int deleteWorkAtt(int workNo) {
		return dao.deleteWorkAtt(session, workNo);
	}

	@Override
	public int deleteWork(int workNo) {
		return dao.deleteWork(session, workNo);
	}

}
