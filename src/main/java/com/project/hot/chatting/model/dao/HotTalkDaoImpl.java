package com.project.hot.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
@Repository
public class HotTalkDaoImpl implements HotTalkDao {

	@Override
	public List<ResponseEmployeeDTO> getHotTalkMemberList(SqlSession session) {
		return session.selectList("hottalk.getHotTalkMemberList");
	}

	@Override
	public List<ResponseHotTalkListDTO> getPrivateHotTalkList(SqlSession session, int employeeNo) {
		return session.selectList("hottalk.getPrivateHotTalkList", employeeNo);

	}

	@Override
	public List<ResponseHotTalkListDTO> getGroupHotTalkList(SqlSession session, int employeeNo) {
		return session.selectList("hottalk.getGroupHotTalkList", employeeNo);
	}

}
