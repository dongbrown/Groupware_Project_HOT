package com.project.hot.employee.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RequestEmployee {
	// 업데이트용 사원 클래-스
	private int employeeNo;
	private int departmentCode;
	private int positionCode;
	private String employeeName;
	private String employeePhone;
	private String employeePassword;
	private String employeeId;
	private String employeeAddress;
	private int employeeSalary;	
	private Date employeeHireDate;
	private Date employeeResignationDay;
	private int employeeTotalVacation;
}
