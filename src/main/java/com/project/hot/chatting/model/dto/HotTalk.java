package com.project.hot.chatting.model.dto;

import java.time.LocalDateTime;
import java.util.List;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HotTalk {
	private int employeeNo;
	private String hotTalkIsGroup;
	private int hotTalkNo;
	private String hotTalkTitle;
	private LocalDateTime hotTalkMakeDate;
	private List<HotTalkContent> contents;
	private List<Employee> members;
	private List<HotTalkAtt> attachments;
}
