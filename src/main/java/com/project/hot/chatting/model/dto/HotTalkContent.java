package com.project.hot.chatting.model.dto;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HotTalkContent {
	private int hotTalkContentNo;
	private int hotTalkNo;
	private String hotTalkContent;
	private LocalDateTime hotTalkContentDate;
	private ResponseEmployeeDTO hotTalkContentSender;
	private List<HotTalkReceiver> hotTalkReceiver;
}
