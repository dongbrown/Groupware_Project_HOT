package com.project.hot.approval.model.dto;

import java.sql.Date;

import com.project.hot.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Approver {

	private int approverNo;
	private String approvalNo;
	private Employee employeeNo;
	private int approverStatus;
	private Date approverDate;
	private String approverReject;
	private int approverLevel;

}
