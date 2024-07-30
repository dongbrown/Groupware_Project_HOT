package com.project.hot.chatting.model.service;

import java.util.ArrayList;
import java.util.HashMap;
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
	private final NotificationService sseService;
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
	    List<Integer> receivers = new ArrayList<>();
	    try {
	        result = dao.insertMessageSender(session, msg);
	        if (result > 0) {
	            result = dao.insertMessageReceiver(session, msg);
	            receivers = getReceivers(msg.getHotTalkNo());
	            receivers.forEach(r->{
	            	if(r!=msg.getSender()) sseService.sendInitEvent(r);
	            });
	            if (result == 0) {
	                throw new ChattingException("수신자 정보 저장 실패");
	            }
	        } else {
	            throw new ChattingException("발신자 정보 저장 실패");
	        }
	    } catch (RuntimeException e) {
	        throw new ChattingException("채팅 내용 저장 실패 : " + e.getMessage());
	    }
	    return result;
	}
	@Override
	public int insertHotTalkAtt(HotTalkAtt hotTalkAtt) {
		// System.out.println(hotTalkAtt);
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
	@Override
	@Transactional
	public int insertNewChatRoom(CommonMessageDTO msg) {
	    try {
	        insertChatRoom(msg);
	        insertChatRoomMember(msg);
	        insertChatRoomContents(msg);
	        insertChatRoomReceiver(msg);
	        if(msg.getReceivers().size()>=2) {
	        	return msg.getHotTalkNo();
	        } else {
	        	return getPrivateTalkNo(msg.getSender(), msg.getReceiver());
	        }
	    } catch (Exception e) {
	        throw new ChattingException("채팅방 생성 실패: " + e.getMessage());
	    }
	}

	private List<Integer> getReceivers(int hotTalkNo){
		return dao.getReceivers(session, hotTalkNo);
	}

	private void insertChatRoom(CommonMessageDTO msg) {
	    int result = dao.insertNewChatRoom(session, msg);
	    if (result <= 0) {
	        throw new ChattingException("채팅방 생성 실패");
	    }
	}

	private void insertChatRoomMember(CommonMessageDTO msg) {
	    int result = dao.insertNewChatRoomMember(session, msg);
	    if (result <= 0) {
	        throw new ChattingException("채팅방 멤버 추가 실패");
	    }
	}

	private void insertChatRoomContents(CommonMessageDTO msg) {
	    int result = dao.insertNewChatRoomContents(session, msg);
	    if (result <= 0) {
	        throw new ChattingException("채팅방 내용 추가 실패");
	    }
	}

	private void insertChatRoomReceiver(CommonMessageDTO msg) {
	    int result = dao.insertNewChatRoomReceiver(session, msg);
	    if (result <= 0) {
	        throw new ChattingException("채팅방 수신자 추가 실패");
	    }
	}

	private int getPrivateTalkNo(int sender, String receiver) {
	    Map<String, Integer> param = new HashMap<>();
	    param.put("clickedNo", Integer.parseInt(receiver));
	    param.put("loginEmployeeNo", sender);
	    return dao.getHotTalkNo(session, param);
	}
	@Override
	public void updateIsReadByNo(Map<String, Integer> param) {
		int result = dao.updateIsReadByNo(session, param);
		if(result > 0) {
			sseService.sendInitEvent(param.get("empNo"));
		}
	}

}
