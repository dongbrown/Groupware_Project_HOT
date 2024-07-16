package com.project.hot.employee.model.dto;

import java.time.LocalDate;

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
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate minHire;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate maxHire;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate minResign;
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate maxResign;
}
