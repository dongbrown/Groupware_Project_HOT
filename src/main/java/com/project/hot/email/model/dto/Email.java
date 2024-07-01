package com.project.hot.email.model.dto;

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
public class Email {

	private int emailNo;
	private Employee employee;
	private String emailTitle;
	private String emailContent;
	private Date emailSendDate;
	private int emailCategoryNo;
	private String emailIsDelete;
}
