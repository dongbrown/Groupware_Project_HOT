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
	public class Employee {

		private int employeeNo;
		private Department departmentCode;
		private Position positionCode;
		private String employeeName;
		private String employeePhone;
		private String employeePassword;
		private String employeeId;
		private String employeeAddress;
		private Date employeeBirthDay;
		private String employeeSsn;
		private Date employeeHireDate;
		private int employeeSalary;
		private String employeePhoto;
		private Date employeeResignationDay;
		private int employeeTotalVacation;

	}
