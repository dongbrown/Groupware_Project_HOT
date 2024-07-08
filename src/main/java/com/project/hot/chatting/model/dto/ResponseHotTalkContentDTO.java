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
public class ResponseHotTalkContentDTO {
	private String type;
	private ResponseEmployeeDTO sender;	// 발신자
	private String hotTalkIsGroup;	// 그룹 여부
	private int hotTalkNo;	// 해당 핫톡
	private String hotTalkTitle; // 핫톡 제목
	private LocalDateTime hotTalkContentDate;	// 만들어진 시각
	private List<HotTalkContent> contents;
	private List<HotTalkAtt> attachments;
	private List<HotTalkReceiver> receivers;
}
