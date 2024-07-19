package com.project.hot.chatting.model.dto;

import java.sql.Timestamp;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class HotTalkMember {
	// private String type;
	private int hotTalkNo;
	private String hotTalkLeader;
	private Timestamp hotTalkEnterDate;
	private Employee hotTalkMember;
	private Department department;
	private HotTalkStatus hotTalkStatus;
}
