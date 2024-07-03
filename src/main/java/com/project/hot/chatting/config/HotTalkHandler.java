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

	Map<String, WebSocketSession> employees = new HashMap<>();


	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

	}

	public void enterEmployees(WebSocketSession session, CommonMessageDTO msg) {
		employees.put(msg.getSender(), session);
		List<ResponseEmployeeDTO> list = service.getHotTalkMemberList();
		list.forEach(l->l.setType("사원"));
		// System.out.println(list);
		responseEmployeeDTO(list);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		CommonMessageDTO msg = mapper.readValue(message.getPayload(), CommonMessageDTO.class);
		switch(msg.getType()){
			case "enter" : enterEmployees(session, msg); break;
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}

	private void responseEmployeeDTO(List<ResponseEmployeeDTO> list) {
		for(Map.Entry<String, WebSocketSession> employee : employees.entrySet()) {
			WebSocketSession emp = employee.getValue();
			try {
				String message = mapper.writeValueAsString(list);
				emp.sendMessage(new TextMessage(message));
			}catch(Exception e){
				log.debug("responseMessage() 실패");
			}
		}
	}

	private void responseMessage(CommonMessageDTO msg) {
		for(Map.Entry<String, WebSocketSession> employee : employees.entrySet()) {
			WebSocketSession emp = employee.getValue();
			try {
				String message = mapper.writeValueAsString(msg);
				emp.sendMessage(new TextMessage(message));
			}catch(Exception e){
				log.debug("responseMessage() 실패");
			}
		}
	}

}
