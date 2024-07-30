package com.project.hot.approval.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VacationForm {

	private int vacationFormNo;
	private String approvalNo;
	private Date vacationStart;
	private Date vacationEnd;
	private int vacationDay;
	private String vacationType;
	private String vacationEmergency;
}
