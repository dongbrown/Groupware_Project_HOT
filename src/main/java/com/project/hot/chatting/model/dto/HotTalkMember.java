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
public class HotTalkMember {
	private int hotTalkNo;
	private int employeeNo;
	private String hotTalkLeader;
	private LocalDateTime hotTalkEnterDate;
}
