package com.project.hot.chatting.model.dto;

import java.sql.Timestamp;

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
	private HotTalkContent hotTalkContent;
	private Timestamp hotTalkContentDate;
	private int senderNo;
	private int receiverNo;
	private String senderName;
	private String receiverName;
}
