package com.project.hot.chatting.model.dto;

import java.util.List;

import com.project.hot.employee.model.dto.Department;
import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResponseOtherEmployeeDTO {
	private Employee receiver;	// 전 사원(로그인 유저 제외)
	private HotTalkStatus receiverStatus;	// 로그인 유저를 제외한 전 사원의 상태
	private Department receiverDept;
}
