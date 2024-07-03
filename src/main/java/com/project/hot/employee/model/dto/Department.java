package com.project.hot.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Department {

	private int departmentCode;
	private int departmentHighCode;
	private String departmentTitle;
	private String departmentAuthority;

}