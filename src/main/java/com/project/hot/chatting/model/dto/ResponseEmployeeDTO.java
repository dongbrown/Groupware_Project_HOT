package com.project.hot.chatting.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class ResponseEmployeeDTO {
	private String type;
	private int employeeNo;
	private String employeeName;
	private String departmentCode;
	private String employeePhoto;
	private String status;
	private String profile;
}
