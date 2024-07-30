package com.project.hot.chatting.model.service;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.project.hot.chatting.model.dao.HotTalkDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	// NotificationService ? SSE 연결을 관리하고 메세지를 전송하는 Class
	private final HotTalkDao dao;
	private final Map<Integer, SseEmitter> emitters = new ConcurrentHashMap<>();
	// key : 사용자 아이디 / SseEmitter ? WebSocket에서의 Session 느낌으로 관리
	private final SqlSession session;

	// Time out 설정 → 1시간
	private static final Long DEFAULT_TIMEOUT = 60L*1000*60;

	public SseEmitter subscribe(int loginEmployeeNo) {
		SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
		emitters.put(loginEmployeeNo, emitter);
		// TimeOut 및 연결 종료 시 관리하는 Map에서 제거
		emitter.onCompletion(()->emitters.remove(loginEmployeeNo));
		emitter.onTimeout(()->emitters.remove(loginEmployeeNo));
		// 연결 즉시 이벤트 전송
		sendInitEvent(loginEmployeeNo);

		return emitter;
	}

	public void sendInitEvent(int loginEmployeeNo) {
		if(emitters.containsKey(loginEmployeeNo)) {
		SseEmitter emitter = emitters.get(loginEmployeeNo);
			try {
				emitter.send(SseEmitter.event().name("Init").data(dao.selectMyMessage(session, loginEmployeeNo)));
			}catch(IOException e) {
				emitter.completeWithError(e);
			}
		}
	}

	// 특정 사용자에게 message String 값을 보내주는 메소드
	public void sendNotification(int employeeNo) {
		SseEmitter emitter = emitters.get(employeeNo);
		if(emitter != null) {
			try {
				emitter.send(SseEmitter.event().name("Message").data(dao.selectMyMessage(session, employeeNo)));
			}catch(IOException e) {
				emitters.remove(employeeNo);
				emitter.completeWithError(e);
			}
		}
	}


}
