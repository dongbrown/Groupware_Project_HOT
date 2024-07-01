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
public class HotTalkMessage {
	private String type;
	private String hotTalkTitle;
	private int employeeNo;
	private int hotTalkNo;
	private LocalDateTime eventTime;
}
