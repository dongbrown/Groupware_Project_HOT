package com.project.hot.chatting.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.chatting.model.dao.HotTalkDao;
import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HotTalkServiceImpl implements HotTalkService {

	private final HotTalkDao dao;
	private final SqlSession session;
	@Override
	public List<ResponseEmployeeDTO> getHotTalkMemberList() {
		return dao.getHotTalkMemberList(session);
	}

}
