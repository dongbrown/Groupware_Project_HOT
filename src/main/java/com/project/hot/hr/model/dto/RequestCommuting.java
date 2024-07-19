package com.project.hot.hr.model.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RequestCommuting {
	private Date searchDate;
	private int departmentCode;
	private String status;
	private String employeeName;
	private LocalDateTime goTime;
	private LocalDateTime leaveTime;
	private int commutingNo;
}
