package com.project.hot.chatting.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HotTalkAtt {
	private int hotTalkAttNo;
	private int hotTalkNo;
	private String hotTalkOriginalFilename;
	private String hotTalkRenamedFilename;
}
