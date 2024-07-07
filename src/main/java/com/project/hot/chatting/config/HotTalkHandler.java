package com.project.hot.chatting.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hot.chatting.model.dto.CommonMessageDTO;
import com.project.hot.chatting.model.dto.ResponseEmployeeDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkContentDTO;
import com.project.hot.chatting.model.dto.ResponseHotTalkListDTO;
import com.project.hot.chatting.model.service.HotTalkService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
@RequiredArgsConstructor
public class HotTalkHandler extends TextWebSocketHandler {
	@Autowired
	private ObjectMapper mapper;

	private final HotTalkService service;

	Map<Integer, WebSocketSession> employees = new HashMap<>();


	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

	}

	private void enterEmployees(WebSocketSession session, CommonMessageDTO msg) {
		employees.put(msg.getSender(), session);
		List<ResponseEmployeeDTO> list = service.getHotTalkMemberList();
		list.forEach(l->l.setType("사원"));
		// System.out.println(list);
		responseListDTO(list);
	}

	private void privateHotTalkList(WebSocketSession session, CommonMessageDTO msg) {
		List<ResponseHotTalkListDTO> list = service.getPrivateHotTalkList(msg.getSender());
		list.forEach(l->l.setType("갠톡"));
		responseListDTO(list);
	}

	private void groupHotTalkList(WebSocketSession session, CommonMessageDTO msg) {
		List<ResponseHotTalkListDTO> list = service.getGroupHotTalkList(msg.getSender());
		list.forEach(l->l.setType("단톡"));
		responseListDTO(list);
	}
	private void getHotTalkContents(WebSocketSession sessionm, CommonMessageDTO msg) {
		List<ResponseHotTalkContentDTO> contents = service.getHotTalkContents(msg.getSender(), msg.getHotTalkNo());
		// System.out.println(contents);
		contents.forEach(c->{
			c.setType("open");
			// System.out.println(c);
		});
		System.out.println(contents);
		responseListDTO(contents);
	}
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		CommonMessageDTO msg = mapper.readValue(message.getPayload(), CommonMessageDTO.class);
		switch(msg.getType()){
			case "enter" : enterEmployees(session, msg); break;
			case "privateHotTalk" : privateHotTalkList(session, msg); break;
			case "groupHotTalk" : groupHotTalkList(session, msg); break;
			// const msg = new CommonMessage("open", sender, "", hotTalkNo, "").convert();로 전달 → 채팅방 내역 조회
			case "open" : getHotTalkContents(session, msg);
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}

	private void responseListDTO(List list) {
		for(Map.Entry<Integer, WebSocketSession> employee : employees.entrySet()) {
			WebSocketSession emp = employee.getValue();
			try {
				String message = mapper.writeValueAsString(list);
				emp.sendMessage(new TextMessage(message));
			}catch(Exception e){
				log.debug("responseMessage() 실패");
			}
		}
	}


}
