package com.project.hot.chatting.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.project.hot.chatting.model.service.NotificationService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class NotificationController {
	// NotificationController ? Client의 SSE 연결 요청을 처리하는 Controller
	private final NotificationService service;

	@GetMapping(value="/subscribe/{loginEmployeeNo}", produces=MediaType.TEXT_EVENT_STREAM_VALUE)
	public SseEmitter subscribe(@PathVariable(value="loginEmployeeNo") int employeeNo) {
		return service.subscribe(employeeNo);
	}
}
