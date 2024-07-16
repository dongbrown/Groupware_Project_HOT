package com.project.hot.employee.model.dto;

import java.time.LocalDateTime;

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
	private LocalDateTime minHire;
	private LocalDateTime maxHire;
	private LocalDateTime minResign;
	private LocalDateTime maxResign;
}
