package com.project.hot.chatting.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class Message {
	private String type;
	private String sender;	// employeeName
	private String receiver;	// employeeName
	private int hotTalkNo;
	private String msg;
	private LocalDateTime eventTime;
}
