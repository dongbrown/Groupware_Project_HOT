package com.project.hot.employee.model.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SearchEmployeeData {
	private int no;
	private String name;
	private String title;
	private String[] positions;
	private int minSalary;
	private int maxSalary;
	private Date minHire;
	private Date maxHire;
	private Date minResign;
	private Date maxResign;
}
