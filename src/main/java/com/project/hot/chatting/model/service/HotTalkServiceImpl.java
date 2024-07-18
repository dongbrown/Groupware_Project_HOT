package com.project.hot.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hot.chatting.model.dao.HotTalkDao;
import com.project.hot.chatting.model.dto.CommonMessageDTO;
import com.project.hot.chatting.model.dto.HotTalkAtt;
import com.project.hot.chatting.model.dto.HotTalkMember;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
import com.project.hot.chatting.model.dto.ResponseLoginEmployeeDTO;
import com.project.hot.common.exception.ChattingException;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class HotTalkServiceImpl implements HotTalkService {

	private final HotTalkDao dao;
	private final SqlSession session;
	@Override
	public List<ResponseLoginEmployeeDTO> getHotTalkMemberList(int empNo) {
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

	@Override
	@Transactional
	public int insertHotTalkMessage(CommonMessageDTO msg) {
	    int result;
	    try {
	       // log.info("발신자 정보 저장 시도: " + msg);
	        result = dao.insertMessageSender(session, msg);
	       // log.info("발신자 정보 저장 결과: " + result);
	        if (result > 0) {
	           // log.info("수신자 정보 저장 시도: " + msg);
	            result = dao.insertMessageReceiver(session, msg);
	           // log.info("수신자 정보 저장 결과: " + result);
	            if (result == 0) {
	                throw new ChattingException("수신자 정보 저장 실패");
	            }
	        } else {
	            throw new ChattingException("발신자 정보 저장 실패");
	        }
	    } catch (RuntimeException e) {
	       // log.error("채팅 내용 저장 중 오류 발생: " + e.getMessage(), e);
	        throw new ChattingException("채팅 내용 저장 실패 : " + e.getMessage());
	    }
	    return result;
	}
	@Override
	public int insertHotTalkAtt(HotTalkAtt hotTalkAtt) {
		return dao.insertHotTalkAtt(session, hotTalkAtt);
	}
	@Override
	public int getHotTalkNo(Map<String, Integer> param) {
		return dao.getHotTalkNo(session, param);
	}
	@Override
	public HotTalkMember selectMember(int employeeNo) {
		return dao.selectMember(session, employeeNo);
	}

}
