package com.project.hot.approval.model.dto;

import java.sql.Date;

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
	private Approval approvalNo;
	private Date overtimeStartDate;
	private Date overtimeEndDate;
	private int overtimeHours;
}
