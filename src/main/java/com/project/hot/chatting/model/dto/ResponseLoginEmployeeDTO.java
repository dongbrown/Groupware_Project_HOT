package com.project.hot.chatting.model.dto;

import java.util.List;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class ResponseLoginEmployeeDTO {
	private String type;
	private Employee sender;	// 로그인 유저
	private HotTalkStatus senderStatus;	// 로그인 유저 상태 및 메세지
	private Department senderDept;
	private List<ResponseOtherEmployeeDTO> receiver;
}


