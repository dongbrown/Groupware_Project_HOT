package com.project.hot.chatting.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.project.hot.chatting.model.dao.HotTalkDao;
import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HotTalkServiceImpl implements HotTalkService {

	private final HotTalkDao dao;
	private final SqlSession session;
	@Override
	public List<ResponseEmployeeDTO> getHotTalkMemberList(int empNo) {
		return dao.getHotTalkMemberList(session, empNo);
	}
	@Override
	public List<ResponseHotTalkListDTO> getPrivateHotTalkList(int employeeNo) {
		return dao.getPrivateHotTalkList(session, employeeNo);
	}
	@Override
	public List<ResponseHotTalkListDTO> getGroupHotTalkList(int employeeNo) {
		return dao.getGroupHotTalkList(session, employeeNo);
	}
	@Override
	public List<ResponseHotTalkContentDTO> getHotTalkContents(int openEmployeeNo, int openHotTalkNo) {
		return dao.getHotTalkContents(session, openEmployeeNo, openHotTalkNo);
	}
	@Override
	public int updateHotTalkStatus(int employeeNo, String status) {
		return dao.updateHotTalkStatus(session, employeeNo, status);
	}
	@Override
	public int updateHotTalkStatusMessage(int employeeNo, String statusMsg) {
		return dao.updateHotTalkStatusMessage(session, employeeNo, statusMsg);
	}

}
