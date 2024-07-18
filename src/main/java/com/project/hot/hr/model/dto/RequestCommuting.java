package com.project.hot.hr.model.dto;

import java.sql.Date;

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
	private String departmentTitle;
	private String status;
	private String employeeName;
}
