package com.project.hot.chatting.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;

public interface HotTalkDao {
	List<ResponseEmployeeDTO> getHotTalkMemberList(SqlSession session);
	List<ResponseHotTalkListDTO> getPrivateHotTalkList(SqlSession session, int employeeNo);
	List<ResponseHotTalkListDTO> getGroupHotTalkList(SqlSession session, int employeeNo);
}
