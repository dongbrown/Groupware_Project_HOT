package com.project.hot.chatting.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HotTalkReceiver {
	private int hotTalkContentNo;
	private int employeeNo;
	private String hotTalkContentIsread;
}
