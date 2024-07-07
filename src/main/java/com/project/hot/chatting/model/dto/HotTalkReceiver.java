package com.project.hot.chatting.model.dto;

import java.util.List;

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
	private String receiverName;
	private String departmentCode;
	private String employeePhoto;
	private String status;
	private String profile;
	private String hotTalkContentIsread;
}
