package com.project.hot.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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

	@Override
	public List<Work> selectWorkAllByEmpNo(SqlSession session, Map<String, Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		return session.selectList("work.selectWorkAllByEmpNo",param,rb);
	}

	@Override
	public List<Work> selectWorkAll(SqlSession session, Map<String, Integer> param) {
		RowBounds rb = new RowBounds((param.get("cPage")-1)*param.get("numPerpage"),param.get("numPerpage"));
		return session.selectList("work.selectWorkAll",null,rb);
	}

	@Override
	public int selectworkAllCountByEmpNo(SqlSession session, Map<String, Integer> param) {
		return session.selectOne("work.selectworkAllCountByEmpNo",param);
	}

	@Override
	public int selectworkAllCount(SqlSession session) {
		return session.selectOne("work.selectworkAllCount");
	}

	@Override
	public Work selectWorkByWorkNo(SqlSession session, int workNo) {
		return session.selectOne("work.selectWorkByWorkNo",workNo);
	}

	@Override
	public int updateWorkDetail(SqlSession session, Work work) {
		return session.update("work.updateWorkDetail",work);
	}

	@Override
	public int deleteWorkAtt(SqlSession session, List<String> delAttName) {
		return session.delete("work.deleteWorkAtt",delAttName);
	}

}
