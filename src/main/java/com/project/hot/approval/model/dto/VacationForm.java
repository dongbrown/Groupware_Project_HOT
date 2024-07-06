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
	private int vacationNo;
	private Date vacationApplocationDate;
	private Date vacationStart;
	private Date vacationEnd;
	private String vacationPurpose;
	private int vacationDay;
	private String vacationType;
	private int employeeId;
	//employeeId,Name 등 필요
}
