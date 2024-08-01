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
public class CommonMessageDTO {
	private String type;
	private int sender;
	private String receiver;	// employeeName
	private int hotTalkNo;
	private String msg;
	private LocalDateTime eventTime;
	private int hotTalkContentNo;
	private int receiverNo;
	private String title;
	private String hotTalkOriginalFilename;
	private List<Integer> receivers;
}


