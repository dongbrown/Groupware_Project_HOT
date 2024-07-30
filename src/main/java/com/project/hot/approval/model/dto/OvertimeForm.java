package com.project.hot.approval.model.dto;

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
public class OvertimeForm {

	private int overtimeFormNo;
	private String approvalNo;
	private Date overtimeDate;
	private LocalDateTime overtimeStartTime;
	private LocalDateTime overtimeEndTime;
	private int overtimeHours;
}
