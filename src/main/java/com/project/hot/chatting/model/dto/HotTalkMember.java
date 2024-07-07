package com.project.hot.chatting.model.dto;

import java.time.LocalDateTime;

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
	private int hotTalkNo;
	private String employeeName;
	private String departmentCode;
	private String employeePhoto;
	private String hotTalkLeader;
	private LocalDateTime hotTalkEnterDate;
	private HotTalkStatus status;
}
