package com.project.hot.chatting.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class HotTalkStatus {
	private int employeeNo;
	private String hotTalkStatus;
	private String hotTalkStatusMessage;
}
