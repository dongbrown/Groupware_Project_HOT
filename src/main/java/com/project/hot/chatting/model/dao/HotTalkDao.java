package com.project.hot.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;

public interface HotTalkDao {
	List<ResponseEmployeeDTO> getHotTalkMemberList(SqlSession session);
}
