package com.project.hot.chatting.model.dto;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class ResponseHotTalkListDTO {
	private String type;
	private String hotTalkIsgroup;
	private String hotTalkTitle;
	private int hotTalkNo;
	private List<HotTalkContent> hotTalkContent;
	private Timestamp hotTalkContentDate;
	private String sender;
}
