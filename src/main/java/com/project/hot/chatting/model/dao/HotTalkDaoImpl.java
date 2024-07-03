package com.project.hot.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
@Repository
public class HotTalkDaoImpl implements HotTalkDao {

	@Override
	public List<ResponseEmployeeDTO> getHotTalkMemberList(SqlSession session) {
		return session.selectList("hottalk.getHotTalkMemberList");
	}

}
